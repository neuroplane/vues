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
    _month int;
    _year int;
    _ktu_month_sum float;
    _ktu_month_amount float;
    _ktu_month_lines float;
    _ktu_month_documents float;
    _actual_ktu float;
    _ndfl float;
BEGIN

    _selected_user = requireint(params, 'selected_user');
    _month = requireint(params, 'month');
    _year = requireint(params, 'year');
    _ktu_month_sum = (SELECT SUM(c_sum) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_amount = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_lines = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_documents = (SELECT SUM(c_documents) from public.ktu k where k.period_month = _month and k.period_year = _year);

    select k.c_sum/_ktu_month_sum + k.c_documents/_ktu_month_documents
    from ktu k
    where k.user_id = _selected_user and k.period_year = _year and k.period_month = _month
    into _actual_ktu;

    SELECT ndfl from taxes where user_id = _selected_user and period_year = _year and period_month = _month into _ndfl;
    _report_date = requiredate(params, 'report_date');
    _user_id = get_user(_token);
    --------------------------------------------------------------------------------------------------------
    SELECT json_agg(a)
    INTO _response
    FROM (
        select round((_actual_ktu*100)::NUMERIC,2) as ktu, _ndfl, u.id, u.surname from users u
        full join ktu k2 on u.id = k2.user_id
        where u.id = _selected_user and k2.period_month = _month and k2.period_year = _year
    ) AS a;
    --------------------------------------------------------------------------------------------------------
    RETURN coalesce(_response,'[]');
END
$$;

alter function individualzp(json, uuid) owner to neuroplane;

select public.individualzp('{"report_date":"2021-05-01", "selected_user":19, "month": 4, "year": 2021}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);