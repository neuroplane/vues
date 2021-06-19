DROP FUNCTION IF EXISTS getusers(JSON, UUID);
create function getusers(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _report_date date;
    _user_id bigint;
BEGIN
    _report_date = requiredate(params, 'report_date');
    _user_id = get_user(_token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    SELECT json_agg(a) INTO _response FROM (
        SELECT u.id as userid, u.surname, u.internal_code,
        u.name, u.patronymic, u.birthday, js.start_date, js.end_date
        from  users u
        left join job_status js on u.id = js.user_id  where js.end_date is null order by u.surname
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function getusers(json, uuid) owner to neuroplane;

select public.getusers('{"report_date":"2021-05-01"}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);