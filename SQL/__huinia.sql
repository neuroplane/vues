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

select sum(m_cash + m_bank)*m_share/10000::float4 as m_fot,
       sum(m_cash + m_bank + sad_cash + sad_bank + mir_cash + mir_bank)*sklad_share/10000::float4 as sklad_fot,
       sum(m_cash + m_bank + sad_cash + sad_bank)*adm_share/10000::float4 as adm_fot
       from constants where period_month=5 and period_year=2021 group by m_share, sklad_share, adm_share