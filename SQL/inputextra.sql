create or replace function inputextra(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into extra(user_id, amount, dop_amount, period_month, period_year) values($1, $2, $3, $4, $5)',
        [item.user_id, item.amount || null, item.dop_amount || null, item.period_month, item.period_year]);
    }

    return {inserted: params.items}

$$;

alter function inputextra(json, uuid) owner to neuroplane;