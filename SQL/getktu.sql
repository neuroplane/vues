drop function if exists test2(params json, _token uuid);
create function test2(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _month integer;
BEGIN
    _month = requireint(params, 'month');
    SELECT json_agg(a) INTO _response FROM (
        SELECT m.month_ru, u.surname, k.c_sum, k.c_amount, k.c_lines,
               (SELECT k.c_sum*2) as cool from public.ktu k
            join users u on k.user_id = u.id
            join public.months m on m.month_id = k.period_month
        where k.period_month = _month
    ) AS  a;
    RETURN coalesce(_response,'[]');
END
$$;

alter function test2(json, uuid) owner to neuroplane;

