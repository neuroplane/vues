DROP FUNCTION IF EXISTS updateusers(JSON, UUID);
CREATE OR REPLACE FUNCTION updateusers(params JSON, _token uuid)
RETURNS JSON AS $$
DECLARE
    _response JSON;
    _items json;
    _item json;
BEGIN
    _items = requirejson(params, 'items');

    for _item in select * from (select json_array_elements(_items) as value) a where value->>'price' notnull loop
        insert into study.prices (user_id, quiz_type_id, price, level)
        select _user_selected, (v->>'quiz_id')::bigint, (v->>'price')::int, (v->>'level')::int from (
        select json_array_elements(_items) v
        ) a where v->>'price' notnull
        on conflict ON CONSTRAINT prices_pk do update set price = EXCLUDED.price,level = EXCLUDED.level;
    end loop;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM updateusers('{}'::JSON, '952bd5ed-e6f2-4590-8d50-a6b35c0467d1');
