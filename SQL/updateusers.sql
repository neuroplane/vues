DROP FUNCTION IF EXISTS updateuser(json,uuid);
CREATE OR REPLACE FUNCTION updateuser(params json, _token uuid)  RETURNS json AS $$
DECLARE

    _items json;
    _response json;
    _user_selected bigint;
    _user_id bigint;
    _family_id bigint;
BEGIN
    _user_id = study.get_user(_token);
    _items = requirejson(params, 'items');
    _user_selected = requirejson(params, 'selid');
    _family_id = (SELECT family_id FROM study.users WHERE id = _user_selected);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    IF (SELECT ((SELECT family_id FROM study.users WHERE id = _user_selected) =
                (SELECT family_id FROM study.users WHERE id = _user_id)))
        IS NOT TRUE THEN RAISE EXCEPTION 'Family interference' USING ERRCODE='ER403';
        END IF;

    for _item in select * from (select json_array_elements(_items) as value) a where value->>'price' notnull loop
        insert into study.prices (user_id, quiz_type_id, price, level)
        select _user_selected, (v->>'quiz_id')::bigint, (v->>'price')::int, (v->>'level')::int from (
        select json_array_elements(_items) v
        ) a where v->>'price' notnull
        on conflict ON CONSTRAINT prices_pk do update set price = EXCLUDED.price,level = EXCLUDED.level;
    end loop;

    RETURN coalesce(_response,'[]');
END $$ LANGUAGE 'plpgsql';

select updateuser('{"items":[{"id":242,"level":15,"price":1,"quiz_details":"a + b","quiz_id":1,"quiz_name":"sum2","user_id":6},{"id":243,"level":3,"price":1,"quiz_details":"a + b + c","quiz_id":2,"quiz_name":"sum3","user_id":6},{"id":240,"level":4,"price":1,"quiz_details":"a - b","quiz_id":3,"quiz_name":"sub2","user_id":6},{"id":241,"level":"2","price":5,"quiz_details":"a * b","quiz_id":4,"quiz_name":"mult2","user_id":6}],"selid":6}'::json, 'd0fd05d9-7b2c-42a6-a8fd-5acb5b6e33ce'::uuid);

select * from jsonb_each('{"userid":38,"surname":"Бурдакова","internal_code":56,"name":"Эллада","patronymic":"Руслановна","birthday":"1984-08-08","start_date":"2017-03-13"}')