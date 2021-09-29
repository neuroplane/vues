create or replace function inputhomework(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id bigint;
    _lesson text;
    _homework text;

BEGIN
    _homework = requiretext(params, 'homework');
    _user_id = get_user(_token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;


    INSERT INTO school.homework (id, timeadded, homework) VALUES (DEFAULT, current_timestamp AT TIME ZONE 'Europe/Moscow', _homework);

    SELECT json_agg(a) INTO _response FROM (
                                               SELECT 'Домашка добавлена' as callback
                                           ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function inputhomework(json, uuid) owner to neuroplane;

select public.inputhomework('{"homework":"TEST HOMEWORK"}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);