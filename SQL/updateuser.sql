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
    _end_date date;
BEGIN
    _user_id = requireint(params, 'userid');
    _name = requiretext(params, 'name');
    _surname = requiretext(params, 'surname');
    _patronymic = requiretext(params, 'patronymic');
    _birthday = requiredate(params, 'birthday');
    _start_date = requiredate(params, 'start_date');
    _end_date = optionaldate(params, 'end_date');
    UPDATE public.users u SET name=_name, surname=_surname, patronymic=_patronymic, birthday=_birthday WHERE u.id = _user_id;

    INSERT INTO job_status (id, user_id, start_date, end_date) VALUES (DEFAULT, _user_id, _start_date, _end_date)
    ON CONFLICT ON CONSTRAINT job_status_user_id_key DO
        UPDATE SET start_date = _start_date, end_date = _end_date;
    SELECT json_agg(a) INTO _response FROM (
        SELECT 'ВСЁ ЗАЕБЦА' as callback
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function updateuser(json, uuid) owner to neuroplane;

select public.updateuser('{"birthday":"1974-11-27","internal_code":null,"name":"Ирина","patronymic":"Викторовна","start_date":"2020-02-22","surname":"Рыкова","userid":73}'::json, 'a01c8943-7cc4-4da3-b1d9-cb1fed43cbd6'::uuid);