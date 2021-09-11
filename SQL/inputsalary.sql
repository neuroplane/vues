create or replace function inputsalary(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into salary(user_id, amount, period_month, period_year, role) values($1, $2, $3, $4, $5)',
        [item.user_id, item.amount != "" ? item.amount : null, item.period_month, item.period_year, item.role]);
    }
    return {inserted: params.items}

$$;

alter function inputsalary(json, uuid) owner to neuroplane;