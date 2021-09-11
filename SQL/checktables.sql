drop function if exists checktables(params json, _token uuid);
create function checktables(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _month integer;
    _year integer;
    _constants bool;
    _credit bool;
    _extra bool;
    _fines_bonuses bool;
    _ktu bool;
    _taxes bool;
    _work_hours bool;
    _salary bool;
BEGIN
    _month = requireint(params, 'month');
    _year = requireint(params, 'year');
    select exists( select period_month from constants where period_month = _month and period_year = _year) into _constants;
    select exists( select period_month from credit where period_month = _month and period_year = _year) into _credit;
    select exists( select period_month from extra where period_month = _month and period_year = _year) into _extra;
    select exists( select period_month from ktu where period_month = _month and period_year = _year) into _ktu;
    select exists( select period_month from fines_bonuses where period_month = _month and period_year = _year) into _fines_bonuses;
    select exists( select period_month from taxes where period_month = _month and period_year = _year) into _taxes;
    select exists( select period_month from work_hours where period_month = _month and period_year = _year) into _work_hours;
    select exists( select period_month from salary where period_month = _month and period_year = _year) into _salary;



    SELECT to_json(a) INTO _response FROM (
        SELECT _constants as Константы, _credit as Авансы, _extra as Надбавки, _ktu as КТУ,
               _fines_bonuses as ШиБ, _taxes as Налоги, _work_hours as Табель, _salary as Оклады
    ) AS  a;
    RETURN coalesce(_response,'[]');
END
$$;

alter function checktables(json, uuid) owner to neuroplane;

select checktables('{"month":7, "year" : 2021}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);
