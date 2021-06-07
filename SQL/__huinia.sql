--Выдрать месяц из даты
select * from users u where (select date_part('month', u.birthday)) = 1;