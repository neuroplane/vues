DROP FUNCTION IF EXISTS getworkingusers(JSON, UUID);
CREATE OR REPLACE FUNCTION getworkingusers(params JSON, _token uuid)
    RETURNS JSON AS $$
DECLARE
    _response JSON;
    _report_date date;
    _user_id int;
    _year int;
    _month int;
    _user_id bigint;
BEGIN
    _user_id = get_user(_token);
    _report_date = requiredate(params, 'report_date');
    _year = requireint(params, 'year');
    _month = requireint(params, 'month');
    _user_id = get_user(_token); --ОБЯЗАТЕЛЬНАЯ СТРОКА

    SELECT json_agg(a) INTO _response FROM (
        SELECT u.id, ((SELECT u.surname) || ' ' || (SELECT LEFT(u.name,1) || '.') || (SELECT LEFT(u.patronymic,1)) || '.') AS fio,
               u.surname, u.name, u.patronymic
               --js.start_date, js.end_date
        FROM  users u
        --    JOIN job_status js ON u.id = js.user_id
        JOIN salary s on u.id = s.user_id
        --WHERE (js.end_date IS NULL AND _report_date > js.start_date)
        --   OR (_report_date BETWEEN js.start_date AND js.end_date)
        WHERE period_month = _month and period_year = _year
        ORDER BY u.surname
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

ALTER FUNCTION getworkingusers(json, uuid) OWNER TO neuroplane;

select public.getworkingusers('{"month":"05","report_date":"2021-5-1","year":"2021"}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);
