create or replace function test2(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _month integer;
    _year int;
    _ktu_month_sum float;
    _ktu_month_amount float;
    _ktu_month_lines float;
    _ktu_month_documents float;
    _user_id int;
BEGIN
    _user_id = get_user(_token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    _month = requireint(params, 'month');
    _year = requireint(params, 'year');
    _ktu_month_sum = (SELECT SUM(c_sum) from public.ktu k where k.period_month = _month);
    _ktu_month_amount = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month);
    _ktu_month_lines = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month);
    _ktu_month_documents = (SELECT SUM(c_documents) from public.ktu k where k.period_month = _month);
    SELECT json_agg(a) INTO _response FROM (
        SELECT m.month_ru, u.surname, k.c_sum, k.c_amount, k.c_lines, k.c_documents,
               (SELECT round((k.c_sum/_ktu_month_sum*100)::NUMERIC,2)) as ktu_sum,
               (SELECT k.c_amount/(SELECT SUM(c_amount) from public.ktu k where k.period_month = _month)) as ktu_amount,
               (SELECT k.c_lines/(SELECT SUM(c_lines) from public.ktu k where k.period_month = _month)) as ktu_lines,
               (SELECT k.c_documents/(SELECT SUM(c_documents) from public.ktu k where k.period_month = _month)) as ktu_documents
               from public.ktu k
            join users u on k.user_id = u.id
            join public.months m on m.month_id = k.period_month
        where k.period_month = _month group by u.surname, m.month_ru, k.c_sum, k.c_amount, k.c_lines, k.c_documents
    ) AS  a;
    RETURN coalesce(_response,'[]');
END
$$;

alter function test2(json, uuid) owner to neuroplane;

