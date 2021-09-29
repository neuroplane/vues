DROP FUNCTION IF EXISTS gethomework(JSON, UUID);
create function gethomework(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id bigint;
BEGIN
    _user_id = get_user(_token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    SELECT to_json(a) INTO _response FROM (
        SELECT
               homework.homework from school.homework order by timeadded desc limit 1
       ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function gethomework(json, uuid) owner to neuroplane;

select public.gethomework('{}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);