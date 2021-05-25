create or replace function updateuser(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id bigint;
    _name text;
    _surname text;
    _patronymic text;
    _birthday date;
    _start_date date;
BEGIN
    _user_id = requireint(params, 'userid');
    _name = requiretext(params, 'name');
    _surname = requiretext(params, 'surname');
    _patronymic = requiretext(params, 'patronymic');
    _birthday = requiredate(params, 'birthday');
    _start_date = requiredate(params, 'start_date');
    UPDATE public.users u SET name=_name, surname=_surname, patronymic=_patronymic, birthday=_birthday WHERE u.id = _user_id;
    UPDATE job_status js SET start_date = _start_date where js.user_id = _user_id;
    SELECT json_agg(a) INTO _response FROM (
        SELECT 'ВСЁ ЗАЕБЦА' as callback
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function updateuser(json, uuid) owner to neuroplane;

