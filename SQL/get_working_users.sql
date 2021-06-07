DROP FUNCTION IF EXISTS getworkingusers(JSON, UUID);
CREATE OR REPLACE FUNCTION getworkingusers(params JSON, _token uuid)
    RETURNS JSON AS $$
DECLARE
    _response JSON;
    _date date;
BEGIN
    _date = requiredate(params, 'report_date');
    SELECT json_agg(a) INTO _response FROM (
        SELECT u.id, ((SELECT u.surname) || ' ' || (SELECT LEFT(u.name,1) || '.') || (SELECT LEFT(u.patronymic,1)) || '.') as fio
        from  users u join job_status js on u.id = js.user_id
        where js.end_date is null
           or _date > js.start_date and _date < js.end_date
        order by u.surname
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

alter function getworkingusers(json, uuid) owner to neuroplane;

SELECT * FROM getworkingusers('{"report_date":"2021-05-01"}'::JSON, 'b9391b1c-b70b-46fd-b142-1d9b5f78979d');
