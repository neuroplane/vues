--Выдрать месяц из даты
select * from users u where (select date_part('month',u.birthday) = (select date_part('month',(select last_day(now())))));

--Текущая дата
select now();

create or replace funCtion last_day(fromdt anyelement)
    returns date as
$BODY$
SELECT (date_trunc('MONTH', cast(fromdt as date)) + INTERVAL '1 MONTH - 1 day')::date;
$BODY$
    LANGUAGE sql VOLATILE
                 COST 100;
ALTER FUNCTION last_day(anyelement)
    OWNER TO neuroplane;

select last_day(now());


select date_part('month',(select last_day(now())))