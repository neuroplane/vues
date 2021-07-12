create or replace function inputtaxes(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into taxes(user_id, ndfl, aliments, bank, period_month, period_year) values($1, $2, $3, $4, $5, $6)',
        [item.user_id,
    item.ndfl != "" ? item.ndfl : null,
    item.aliments != "" ? item.aliments : null,
    item.bank != "" ? item.bank : null,
    item.period_month,
    item.period_year]);
    }

    return {inserted: params.items}

$$;

alter function inputtaxes(json, uuid) owner to neuroplane;