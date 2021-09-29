DROP FUNCTION IF EXISTS randomozhegov(JSON, UUID);
create function randomozhegov(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id bigint;
BEGIN
    _user_id = get_user(_token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    SELECT json_agg(a) INTO _response FROM (
                                               select o.vocab, o.def, o.leglexam from school.ozhegov o where LENGTH(o.vocab) > 6 ORDER BY random() LIMIT 2
                                           ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function randomozhegov(json, uuid) owner to neuroplane;

select public.randomozhegov('{}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);