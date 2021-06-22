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
       from constants group by period_year, period_month, m_share, sklad_share, adm_share order by period_year, period_month