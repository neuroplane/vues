create or replace function inputextra(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into extra(user_id, amount, dop_amount, period_month, period_year) values($1, $2, $3, $4, $5)',
        [item.user_id, item.amount || null, item.dop_amount || null, item.period_year, item.period_month]);
    }

    return {inserted: params.items}

$$;

alter function inputextra(json, uuid) owner to neuroplane;

select public.inputextra('{"items":[{"amount":"3000","dop_amount":"","period_month":"4","period_year":"2021","user_id":"78"},{"amount":"-1800","dop_amount":"","period_month":"4","period_year":"2021","user_id":"5"},{"amount":"1100","dop_amount":"","period_month":"4","period_year":"2021","user_id":"47"},{"amount":"","dop_amount":"","period_month":"4","period_year":"2021","user_id":"42"},{"amount":"","dop_amount":"","period_month":"4","period_year":"2021","user_id":"17"}]}'::json, '70c85b64-84f6-4a11-9c60-9eb319a3d67a'::uuid);