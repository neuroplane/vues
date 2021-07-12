create or replace function inputfinesbonuses(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into fines_bonuses(user_id, fine, bonus, period_month, period_year) values($1, $2, $3, $4, $5)',
        [item.user_id,
    item.fine != "" ? item.fine : null,
    item.bonus != "" ? item.bonus : null,
    item.period_month,
    item.period_year]);
    }

    return {inserted: params.items}

$$;

alter function inputfinesbonuses(json, uuid) owner to neuroplane;