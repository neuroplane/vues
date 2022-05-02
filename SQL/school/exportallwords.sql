DROP FUNCTION IF EXISTS school.exportallwords(JSON, UUID);
create function school.exportallwords(params json, _token uuid) returns json
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
                                               select * from school.english_words w
                                           ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function school.exportallwords(json, uuid) owner to neuroplane;

select school.exportallwords('{}'::json, 'af7f8fed-49db-4929-8bda-6639a196d0c1'::uuid);