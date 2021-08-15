create or replace function get_role(_user_id integer, _month integer, _year integer) returns text
    language plpgsql
as
$$
DECLARE
    _role text;
BEGIN
    SELECT r.role_id_ru FROM role_history rh
        JOIN job_status js ON rh.user_id = js.user_id
        JOIN roles r ON rh.role = r.role_id
    WHERE rh.user_id = _user_id AND rh.role_start_date < (select last_day((_year || '-' || _month || '-1')::date))::date ORDER BY role_start_date DESC into _role;
    return _role;
END;
$$;

alter function get_role(integer, integer, integer) owner to neuroplane;

select get_role(60,5,2021)