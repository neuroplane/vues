create or replace function individualzp(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    --_report_date date;
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
    _ktu_bonus float;
    _selected_role text;
    _bonus_base int;
BEGIN

    _selected_user = requireint(params, 'selected_user');
    _month = requireint(params, 'month');
    _year = requireint(params, 'year');
    _ktu_month_sum = (SELECT SUM(c_sum) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_amount = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_lines = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_documents = (SELECT SUM(c_documents) from public.ktu k where k.period_month = _month and k.period_year = _year);



    select k.c_sum/_ktu_month_sum + k.c_documents/_ktu_month_documents from ktu k
    where k.user_id = _selected_user
      and k.period_year = _year
      and k.period_month = _month
    into _actual_ktu;

    SELECT ndfl from taxes
    where user_id = _selected_user
      and period_year = _year
      and period_month = _month
    into _ndfl;
    --_report_date = requiredate(params, 'report_date');
    _user_id = get_user(_token); --ОБЯЗАТЕЛЬНАЯ СТРОКА
    --------------------------------------------------------------------------------------------------------
    SELECT to_json(a)
    INTO _response
    FROM (
             select m.month_ru,
                    get_fot_type(_selected_user, _month, _year) as fot,
                    cnst.work_hours as month_standard,
                    wh.hours,
                    s.amount as salary,
                    (select ROUND((wh.hours/cnst.work_hours*s.amount)::NUMERIC,2)) as nachisleno, --НАЧИСЛЕНО
                    round((_actual_ktu*100)::NUMERIC,2) as ktu,
                    u.id,
                    u.surname,
                    u.name,
                    get_role(_selected_user, _month, _year) as role,
                    c.amount as credit,
                    shifts,
                    change,
                    fb.fine,
                    bonus,
                    t.ndfl,
                    aliments,
                    bank,
                    r.role_id_ru,
                    wh.period_year,
                    ex.amount as extra
                    --(SELECT round((k.c_sum/_ktu_month_sum*100)::NUMERIC,2)) as ktu_sum,
             from work_hours wh
                      left join users u on wh.user_id = u.id

                      left join credit c using (period_year, period_month, user_id)
                      left join taxes t using (period_year, period_month, user_id)
                      left join fines_bonuses fb using (period_year, period_month, user_id)
                      left join extra ex using (period_year, period_month, user_id)
                      left join ktu k using (period_year, period_month, user_id)
                      left join role_history rh on u.id = rh.user_id
                      left join roles r on rh.role = r.role_id
                      left join job_status js on u.id = js.user_id
                      left join constants cnst using (period_year, period_month)
                      left join salary s on u.id = s.user_id
                      left join months m on wh.period_month = m.month_id
             where u.id = _selected_user
               and wh.period_month = _month
               and wh.period_year = _year
             -- and js.start_date > _report_date
         ) AS a;
    --------------------------------------------------------------------------------------------------------
    RETURN coalesce(_response,'[]');
END
$$;

alter function individualzp(json, uuid) owner to neuroplane;

