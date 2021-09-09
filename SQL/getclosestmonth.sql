drop function if exists getclosestmonth(params json, _token uuid);
create function getclosestmonth(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id int;
BEGIN
    _user_id = get_user(_token);
    SELECT to_json(a) INTO _response FROM (
                                              select c.period_year as closest_year, c.period_month as closest_month from constants c order by c.period_year, c.period_month desc LIMIT 1
                                          ) AS  a;
    RETURN coalesce(_response,'{}');
END
$$;

alter function getclosestmonth(json, uuid) owner to neuroplane;

select public.getclosestmonth('{}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);