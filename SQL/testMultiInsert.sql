CREATE OR REPLACE FUNCTION testmultiinsert(params json, token uuid) RETURNS JSON LANGUAGE plv8 AS $$

    for (item of params.items){
         plv8.execute('insert into test(a,b) values($1,$2)', [item.a, item.b]);
    }

    return {inserted: params.items}
$$;

alter function testmultiinsert(json, uuid) owner to neuroplane;

select testmultiinsert('{"items": [{"a":"fooz", "b":"barz"}, {"a":"baz","b":"nope"}]}',uuid_generate_v4());