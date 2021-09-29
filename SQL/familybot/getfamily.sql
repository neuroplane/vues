create or replace function neurotlg.getfamily(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _report_date date;
    _user_id int;
BEGIN
    _user_id = get_user(_token);

    SELECT json_agg(a) INTO _response
    FROM
         (
        SELECT p.id as userid, p.name_id, (SELECT (SELECT p.first_name)) as name from neurotlg.people p order by name_id
        )
    AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function neurotlg.getfamily(json, uuid) owner to neuroplane;



