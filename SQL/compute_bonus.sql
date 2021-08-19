DROP FUNCTION IF EXISTS compute_bonus(_user_id integer, _month integer, _year integer);
create or replace function compute_bonus(_user_id integer, _month integer, _year integer) returns float
    language plpgsql
as
$$
DECLARE
    _fot float;
    _ktu float;
    _ktu_month_sum float;
    _ktu_month_amount float;
    _ktu_month_lines float;
    _ktu_month_documents float;
    _actual_ktu float;
BEGIN
    _ktu_month_sum = (SELECT SUM(c_sum) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_amount = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_lines = (SELECT SUM(c_amount) from public.ktu k where k.period_month = _month and k.period_year = _year);
    _ktu_month_documents = (SELECT SUM(c_documents) from public.ktu k where k.period_month = _month and k.period_year = _year);
    SELECT INTO _fot CASE
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('warehouse')
                             THEN (SELECT round((
                                                            (select round(
                                                            (select (k.m_cash + k.m_bank + k.mir_cash + k.mir_bank + k.sad_cash + k.sad_bank)) * k.sklad_share / 100 / 100)
                                                             from constants k
                                                             where period_year = _year
                                                               AND period_month = _month) /
                                                            (select sum(round((w.hours / c.work_hours * s.amount)::numeric, 0))
                                                             from salary s
                                                                      join work_hours w on s.user_id = w.user_id
                                                                 and w.period_month = s.period_month
                                                                 and w.period_year = s.period_year
                                                                      join constants c
                                                                           on s.period_month = c.period_month and s.period_year = c.period_year
                                                                      join users u on s.user_id = u.id
                                                             where s.period_month = _month
                                                               and s.period_year = _year
                                                               and s.role = 'warehouse') *
                                                            (select round((w.hours / c.work_hours * s.amount)::numeric, 0)
                                                             from salary s
                                                                      join work_hours w on s.user_id = w.user_id
                                                                 and w.period_month = s.period_month
                                                                 and w.period_year = s.period_year
                                                                      join constants c
                                                                           on s.period_month = c.period_month and s.period_year = c.period_year
                                                                      join users u on s.user_id = u.id
                                                             where s.period_month = _month
                                                               and s.period_year = _year
                                                               and s.role = 'warehouse'
                                                               and u.id = 12))::numeric, 0))

                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('consultant')
                             THEN (select k.c_sum/_ktu_month_sum + k.c_documents/_ktu_month_documents from ktu k
                                   where k.user_id = _user_id
                                     and k.period_year = _year
                                     and k.period_month = _month)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('адм. бонус', 'посменная')
                             THEN (select k.m_cash + k.m_bank + k.sad_cash + k.sad_bank
                                   from constants k
                                   where period_year = _year
                                     AND period_month = _month)
                         ELSE (select 0)
                         END;
    return _fot;
END;
$$;

alter function compute_bonus(_user_id integer, _month integer, _year integer) owner to neuroplane;

select public.compute_bonus(3, 5, 2021);