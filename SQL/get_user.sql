DROP FUNCTION IF EXISTS get_user(uuid);
CREATE OR REPLACE FUNCTION get_user(_token uuid)
    RETURNS bigint AS $$
DECLARE
    _user_id bigint;
BEGIN
    select id from administrators where token = _token into _user_id;
    if _user_id isnull then raise exception 'WRONG TOKEN' USING ERRCODE='ER401';  end if;
    return _user_id;
END;
$$ LANGUAGE 'plpgsql';

alter function get_user(uuid) owner to neuroplane;