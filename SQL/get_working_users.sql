DROP FUNCTION IF EXISTS getworkingusers(JSON, UUID);
CREATE OR REPLACE FUNCTION getworkingusers(params JSON, _token uuid)
    RETURNS JSON AS $$
DECLARE
    _response JSON;
    _report_date date;
BEGIN
    _report_date = requiredate(params, 'report_date');
    SELECT json_agg(a) INTO _response FROM (
        SELECT u.id, ((SELECT u.surname) || ' ' || (SELECT LEFT(u.name,1) || '.') || (SELECT LEFT(u.patronymic,1)) || '.') AS fio
        FROM  users u JOIN job_status js ON u.id = js.user_id
        WHERE (js.end_date IS NULL AND _report_date > js.start_date)
           OR (_report_date BETWEEN js.start_date AND js.end_date)
        ORDER BY u.surname
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

ALTER FUNCTION getworkingusers(json, uuid) OWNER TO neuroplane;

SELECT * FROM getworkingusers('{"report_date":"2021-05-01"}'::JSON, 'b9391b1c-b70b-46fd-b142-1d9b5f78979d');
