create or replace function ktuinsert(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into ktu_test(user_id, c_sum, c_lines, c_amount, c_documents, period_year, period_month) values($1,$2, $3, $4, $5, $6, $7)',
        [item.user_id, item.c_sum, item.c_lines, item.c_amount, item.c_documents, item.period_year, item.period_month]);
    }


    return {inserted: params.items}

$$;

alter function ktuinsert(json, uuid) owner to neuroplane;

