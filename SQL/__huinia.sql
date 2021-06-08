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

SELECT u.id,
       ((SELECT u.surname) || ' ' || (SELECT LEFT(u.name,1) || '.') || (SELECT LEFT(u.patronymic,1)) || '.') as fio
from  users u
          join job_status js on u.id = js.user_id
where js.end_date is null
or '2021-05-01' > js.start_date and '2021-05-01' < js.end_date
order by u.surname;

select '2021-6-5'::DATE;