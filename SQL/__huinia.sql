--Выдрать месяц из даты
select * from users u where (select date_part('month',u.birthday) = (select date_part('month',(select last_day(now())))));

select u.surname from users u
    join job_status js on u.id = js.user_id
where u.birthday
    BETWEEN
    '1970-12-31'
    AND
    '1979-12-31';

--Текущая дата
select now();

--------
SELECT ('2021-' || (select date_part('month', (select now()))) || '-1')::DATE;

select round(sum((m_cash + m_bank)*m_share/10000)::numeric,0) as m_fot,
       round(sum((m_cash + m_bank + sad_cash + sad_bank + mir_cash + mir_bank)*sklad_share/10000)::numeric,0) as sklad_fot,
       round(sum((m_cash + m_bank + sad_cash + sad_bank)*adm_share/10000)::numeric, 0) as adm_fot,
       period_month, period_year
       from constants group by period_year, period_month, m_share, sklad_share, adm_share order by period_year, period_month;

select rh.role, rh.role_start_date, js.start_date from role_history rh
                                                           join job_status js on rh.user_id = js.user_id
where rh.user_id = 54 and rh.role_start_date<'2010-01-01' order by role_start_date

select SUM(amount), period_month, period_year from salary where role = 'warehouse' group by period_month, period_year order by period_month, period_year;

-- Здесь я получаю сумму начислений по окладу для склада +
select sum(round((w.hours/c.work_hours*s.amount)::numeric, 0))
from salary s
         join work_hours w on s.user_id = w.user_id and w.period_month = s.period_month and w.period_year = s.period_year
         join constants c on s.period_month = c.period_month and s.period_year = c.period_year
         join users u on s.user_id = u.id
where s.period_month = 6 and s.period_year = 2021 and s.role = 'warehouse';

--Здесь получена доля ФОТ склада
select round(((select (k.m_cash + k.m_bank + k.mir_cash + k.mir_bank + k.sad_cash + k.sad_bank))*k.sklad_share/100/100)::numeric,0)
from constants k where period_year = 2021 AND period_month = 04;

-- Здесь я получаю начисление конкретного сотрудникак склада для формулы =(Доля ФОТ)/(Сумма начислений)*(начисления)
select round((w.hours/c.work_hours*s.amount)::numeric, 0)
from salary s
         join work_hours w on s.user_id = w.user_id and w.period_month = s.period_month and w.period_year = s.period_year
         join constants c on s.period_month = c.period_month and s.period_year = c.period_year
         join users u on s.user_id = u.id
where s.period_month = 4 and s.period_year = 2021 and s.role = 'warehouse' and u.id = 12;

--СВОДНАЯ ФОРМУЛА БОНУСОВ
SELECT round((
                         (select round(
                                                 (select (k.m_cash + k.m_bank + k.mir_cash + k.mir_bank + k.sad_cash + k.sad_bank)) *
                                                 k.sklad_share / 100 / 100)
                          from constants k
                          where period_year = 2021
                            AND period_month = 06) /
                         (select sum(round((w.hours / c.work_hours * s.amount)::numeric, 0))
                          from salary s
                                   join work_hours w on s.user_id = w.user_id
                              and w.period_month = s.period_month
                              and w.period_year = s.period_year
                                   join constants c on s.period_month = c.period_month and s.period_year = c.period_year
                                   join users u on s.user_id = u.id
                          where s.period_month = 6
                            and s.period_year = 2021
                            and s.role = 'warehouse') *
                         (select round((w.hours / c.work_hours * s.amount)::numeric, 0)
                          from salary s
                                   join work_hours w on s.user_id = w.user_id
                              and w.period_month = s.period_month
                              and w.period_year = s.period_year
                                   join constants c on s.period_month = c.period_month and s.period_year = c.period_year
                                   join users u on s.user_id = u.id
                          where s.period_month = 6
                            and s.period_year = 2021
                            and s.role = 'warehouse'
                            and u.id = 12))::numeric,0);

ALTER TABLE TABLE_NAME
    ADD CONSTRAINT constraint_name UNIQUE (column1, column2, ... column_n);


/*
 * $ pg_dump --host=localhost --username=xyz db > db-2015-12-01.backup
 * $ psql --host=localhost --username=xyz db
 *
 * http://www.postgresql.org/docs/8.3/static/functions-matching.html
 */

\dt
select * from ci_parameters where ci_parameters.key='tag' and ci_parameters.value ~ 'signed-';;
update ci_parameters set value = regexp_replace(value, 'signed-', 'signed_') where value ~ 'signed-';;
\q