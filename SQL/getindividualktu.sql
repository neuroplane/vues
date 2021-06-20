create function get_individual_ktu(_user_id int, _year int, _month int) returns float8
    language plpgsql
as
$$
DECLARE
    _user_id bigint;
BEGIN
    select id from administrators where token = _token into _user_id;
    if _user_id isnull then raise exception 'Wrong token' USING ERRCODE='ER401';  end if;
    return _user_id;
END;
$$;

alter function get_individual_ktu(uuid) owner to neuroplane;