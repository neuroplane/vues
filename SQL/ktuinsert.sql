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

select ktuinsert('{"items": [{"user_id":"5","c_sum":"1266014.45","c_lines":"1514","c_amount":"25279.4","c_documents":"581.5","period_year":"2021","period_month":"6"},{"user_id":"47","c_sum":"1373842.36","c_lines":"546","c_amount":"2055.5","c_documents":"303","period_year":"2021","period_month":"6"},{"user_id":"42","c_sum":"46410.97","c_lines":"53.5","c_amount":"793","c_documents":"27","period_year":"2021","period_month":"6"},{"user_id":"17","c_sum":"218794.73","c_lines":"56.5","c_amount":"199","c_documents":"39.5","period_year":"2021","period_month":"6"},{"user_id":"3","c_sum":"1608566.61","c_lines":"1698","c_amount":"25611.5","c_documents":"712","period_year":"2021","period_month":"6"},{"user_id":"41","c_sum":"266079","c_lines":"3","c_amount":"914","c_documents":"1.5","period_year":"2021","period_month":"6"},{"user_id":"50","c_sum":"2838135.7","c_lines":"904.5","c_amount":"39515.5","c_documents":"312","period_year":"2021","period_month":"6"},{"user_id":"34","c_sum":"1056","c_lines":"4","c_amount":"10.5","c_documents":"2.5","period_year":"2021","period_month":"6"},{"user_id":"25","c_sum":"1246219.31","c_lines":"2102","c_amount":"25024.5","c_documents":"875.5","period_year":"2021","period_month":"6"}]}', uuid_generate_v4());