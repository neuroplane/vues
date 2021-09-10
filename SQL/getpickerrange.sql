drop function if exists getpickerrange(params json, _token uuid);
create function getpickerrange(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id int;
BEGIN
    _user_id = get_user(_token);
    SELECT json_agg(a) INTO _response FROM (
        select distinct c.period_year, c.period_month from constants c order by c.period_year, c.period_month
    ) AS  a;
    RETURN coalesce(_response,'{}');
END
$$;

alter function getpickerrange(json, uuid) owner to neuroplane;

select public.getpickerrange('{}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);