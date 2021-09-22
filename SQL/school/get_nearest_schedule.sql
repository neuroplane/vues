DROP FUNCTION IF EXISTS getdayschedule(JSON, UUID);
create function getdayschedule(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id bigint;
    _current_time time;
    _nextday_year int;
    _nextday_month int;
    _nextday_day int;
    _nextday_dow int;
BEGIN
    _user_id = get_user(_token);
    select current_time into _current_time;
    select extract(DAY FROM date(current_timestamp + interval '11 hours') AT TIME ZONE 'Europe/Moscow') into _nextday_day;
    select extract(MONTH FROM date(current_timestamp + interval '11 hours') AT TIME ZONE 'Europe/Moscow') into _nextday_month;
    select extract(YEAR FROM date(current_timestamp + interval '11 hours') AT TIME ZONE 'Europe/Moscow') into _nextday_year;
    select extract(ISODOW FROM date(current_timestamp + interval '11 hours') AT TIME ZONE 'Europe/Moscow') into _nextday_dow;
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    SELECT json_agg(a) INTO _response FROM (
        SELECT
               (select ROUND((EXTRACT(EPOCH FROM current_timestamp AT TIME ZONE 'Europe/Moscow'-
                (select make_timestamp(_nextday_year, _nextday_month, _nextday_day, s.time_hours, s.time_minutes, 00)))/3600*60)::float4) * interval '1 minute'  ) as time_to,
               LEFT(make_time(s.time_hours, s.time_minutes, 0)::text, 5) as time, s.lesson_name
        FROM school.schedule_eugene s
        WHERE s.day_of_week = _nextday_dow
        ORDER BY s.id
                                               ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function getdayschedule(json, uuid) owner to neuroplane;

select public.getdayschedule('{}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);