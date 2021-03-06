DROP FUNCTION IF EXISTS users_me(JSON, UUID);
CREATE OR REPLACE FUNCTION users_me(params JSON, _token uuid)
RETURNS JSON AS $$
DECLARE
    _response JSON;
    _user_id int;
BEGIN
    _user_id = (SELECT id from administrators where token = _token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'ERROR HANDLER :: WRONG TOKEN' USING ERRCODE='ER403'; END IF;
    SELECT to_json(a) INTO _response FROM (
        SELECT ulogin, id from administrators WHERE token = _token
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

alter function users_me(json,uuid) owner to neuroplane;

select users_me('{}'::JSON, 'f104bfe2-ebb6-40ec-a0ec-9d80b87d9174'::uuid);
