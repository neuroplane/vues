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

select '2021-6-5'::DATE;

select v.fio, rh.role, r.role_id_ru from v v
    left join role_history rh on rh.user_id = v.id
    left join roles r on r.role_id = rh.role