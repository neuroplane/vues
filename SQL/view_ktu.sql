drop view if exists v;
create or replace view v as
    SELECT ((SELECT u.surname) || (SELECT LEFT(u.name,1)) || (SELECT LEFT(u.patronymic,1))) as fio,
           u.id
    FROM users u
    ORDER BY u.surname;

alter table v
    owner to neuroplane;