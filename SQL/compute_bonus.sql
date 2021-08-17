-- auto-generated definition
create or replace function compute_bonus(_user_id integer, _month integer, _year integer) returns integer
    language plpgsql
as
$$
DECLARE
    _fot float;
BEGIN
    SELECT INTO _fot
        CASE
            WHEN (SELECT get_role(_user_id,_month,_year)) IN ('warehouse')
                THEN (select sum(round((w.hours/c.work_hours*s.amount)::numeric, 0))
                      from salary s
                               join work_hours w on s.user_id = w.user_id and w.period_month = s.period_month and w.period_year = s.period_year
                               join constants c on s.period_month = c.period_month and s.period_year = c.period_year
                               join users u on s.user_id = u.id
                      where s.period_month = _month and s.period_year = _year and s.role = 'warehouse')
            WHEN (SELECT get_role(_user_id,_month,_year)) IN ('адм. бонус', 'посменная')
                THEN (select k.m_cash + k.m_bank + k.sad_cash + k.sad_bank
                      from constants k where period_year = _year AND period_month = _month)
            ELSE (select 0)
            END;
    return _fot;
END;
$$;

alter function compute_bonus(_user_id integer, _month integer, _year integer) owner to neuroplane;

select public.compute_bonus(12,05,2021);