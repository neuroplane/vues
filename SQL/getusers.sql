DROP FUNCTION IF EXISTS getusers(JSON, UUID);
CREATE OR REPLACE FUNCTION getusers(params JSON, _token uuid)
RETURNS JSON AS $$
DECLARE
    _response JSON;
    _something TEXT;
BEGIN
    _something = optionalText(params, 'something');

    SELECT json_agg(a) INTO _response FROM (
        SELECT u.id as userid, u.surname, u.internal_code,
               u.name, u.patronymic, u.birthday, js.start_date, js.end_date
        from  users u
        left join job_status js on u.id = js.user_id  where js.end_date is null order by u.surname
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM getusers('{}'::JSON, null);
