create or replace function inputworkhours(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into work_hours(user_id, hours, change, shifts, period_month, period_year) values($1, $2, $3, $4, $5, $6)',
        [item.user_id,
    item.hours != "" ? item.hours : null,
    item.change != "" ? item.change : null,
    item.shifts != "" ? item.shifts : null,
    item.period_month,
    item.period_year]);
    }

    return {inserted: params.items}

$$;

alter function inputworkhours(json, uuid) owner to neuroplane;