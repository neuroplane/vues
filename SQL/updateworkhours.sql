create function updateworkhours(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id bigint;
    _month int;
    _year int;
    _hours int;
    _change int;
    _shifts int;

BEGIN
    --{"wh_row_id":1,"name":"Сергей","surname":"Васильев","patronymic":"Александрович","fio":"Васильев С.А.","id":2,"hours":100,"change":50,"shifts":null}
    _user_id = requireint(params, 'userid');
    _month = requireint(params, 'month');
    _year = requireint(params, 'year');
    _hours = optionalint(params, 'hours');
    _change = optionalint(params, 'change');
    _shifts = optionalint(params, 'shifts');
    INSERT INTO work_hours (id, period_month, period_year, user_id, hours, change, shifts)
        VALUES (DEFAULT, _user_id, _month, _year, _hours, _change, _shifts)
    ON CONFLICT ON CONSTRAINT work_hours_user_id_period_month_period_year_key
        DO UPDATE SET hours = _hours, change = _change, shifts = _shifts;
    SELECT json_agg(a) INTO _response FROM (
        SELECT 'Update userid ' || _user_id || ' successful' as callback
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function updateworkhours(params json, _token uuid) owner to neuroplane;

select updateworkhours({user_id})

