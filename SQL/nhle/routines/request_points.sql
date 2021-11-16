DROP FUNCTION IF EXISTS nhle.getpoints(JSON, UUID);
create function nhle.getpoints(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _report_date date;
    _user_id bigint;
BEGIN
    _user_id = get_user(_token);
    IF _user_id IS NULL THEN RAISE EXCEPTION 'Wrong username and/or password' USING ERRCODE='ER403'; END IF;
    SELECT json_agg(a) INTO _response FROM (
                                               SELECT s.points || ' (' || s.goals || '+' || s.assists || ')' as points, s.lastname from nhle.summary s order by s.points desc limit 10
        ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function nhle.getpoints(json, uuid) owner to neuroplane;

select nhle.getpoints('{}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);