create or replace function getworkhours(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _work_month int;
    _work_year int;
BEGIN
    _work_month = requireint(params, 'month');
    _work_year = requireint(params, 'year');
    SELECT json_agg(a) INTO _response FROM (
        SELECT wh.id as wh_row_id,
               ((SELECT u.surname) || ' ' || (SELECT LEFT(u.name,1) || '.') || (SELECT LEFT(u.patronymic,1)) || '.') as fio,
               u.id as user_id, wh.hours, wh.change, wh.shifts from  users u
            join work_hours wh on u.id = wh.user_id
            join months m on wh.period_month = m.month_id
        where wh.hours is not null
           or wh.change is not null
           or wh.shifts is not null and wh.period_month = _work_month and wh.period_year = _work_year
        order by u.surname
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function getworkhours(json, uuid) owner to neuroplane;

