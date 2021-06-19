DROP FUNCTION IF EXISTS individualzp(JSON, UUID);
create function individualzp(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _report_date date;
    _user_id bigint;
    _selected_user int;
BEGIN
    _selected_user = requireint(params, 'selected_user');
    _report_date = requiredate(params, 'report_date');
    _user_id = get_user(_token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    --------------------------------------------------------------------------------------------------------
    SELECT json_agg(a)
    INTO _response
    FROM (
        select u.id, u.surname, t.ndfl, fb.fine, fb.bonus, c.amount, rh.role, wh.hours from users u
        left join taxes t on u.id = t.user_id
        left join fines_bonuses fb on t.user_id = fb.user_id
        left join credit c on u.id = c.user_id
        left join role_history rh on u.id = rh.user_id
        left join work_hours wh on u.id = wh.user_id
        where u.id = _selected_user
    ) AS a;
    --------------------------------------------------------------------------------------------------------
    RETURN coalesce(_response,'[]');
END
$$;

alter function individualzp(json, uuid) owner to neuroplane;

select public.individualzp('{"report_date":"2021-05-01", "selected_user":29}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);