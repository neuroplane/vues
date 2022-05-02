DROP FUNCTION IF EXISTS school.randomword(JSON, UUID);
create function school.randomword(params json, _token uuid) returns json
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
                                               select w.word, w.articulation, w.translation, w.example_en, w.example_ru from school.english_words w ORDER BY random() LIMIT 1
                                           ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function school.randomword(json, uuid) owner to neuroplane;

select school.randomword('{}'::json, 'af7f8fed-49db-4929-8bda-6639a196d0c1'::uuid);