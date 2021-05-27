DROP FUNCTION IF EXISTS getavailableusers(JSON, UUID);
CREATE OR REPLACE FUNCTION getavailableusers(params JSON, _token uuid)
RETURNS JSON AS $$
DECLARE
    _response JSON;

BEGIN

    SELECT json_agg(a) INTO _response FROM (
        SELECT u.id,
               ((SELECT u.surname) || ' ' || (SELECT LEFT(u.name,1) || '.') || (SELECT LEFT(u.patronymic,1)) || '.') as fio
        from  users u join job_status js on u.id = js.user_id
        where js.end_date is null order by u.surname
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM getavailableusers('{}'::JSON, 'b9391b1c-b70b-46fd-b142-1d9b5f78979d');
