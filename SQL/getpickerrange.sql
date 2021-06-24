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
    SELECT to_json(a) INTO _response FROM (
        select
            (select c.period_year || '-' || c.period_month from constants c order by c.period_year, c.period_month ASC LIMIT 1) as first_month,
            (select c.period_year || '-' || c.period_month from constants c order by c.period_year, c.period_month DESC LIMIT 1) as last_month
    ) AS  a;
    RETURN coalesce(_response,'{}');
END
$$;

alter function getpickerrange(json, uuid) owner to neuroplane;

select public.getpickerrange('{}'::json, 'f554f079-073f-4b97-b85e-78ed9c8c7fbc'::uuid);