create or replace function inputcredit(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into credit(user_id, amount, period_month, period_year) values($1, $2, $3, $4)',
        [item.user_id, item.amount != "" ? item.amount : null, item.period_month, item.period_year]);
    }

    return {inserted: params.items}

$$;

alter function inputcredit(json, uuid) owner to neuroplane;