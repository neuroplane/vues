DROP FUNCTION IF EXISTS compute_bonus(_user_id INTEGER, _month INTEGER, _year INTEGER);
CREATE OR REPLACE FUNCTION compute_bonus(_user_id INTEGER, _month INTEGER, _year INTEGER) RETURNS INTEGER
    LANGUAGE plpgsql
AS $$
DECLARE
    _fot                 FLOAT;
    _ktu                 FLOAT;
    _ktu_month_sum       FLOAT;
    _ktu_month_amount    FLOAT;
    _ktu_month_lines     FLOAT;
    _ktu_month_documents FLOAT;
    _actual_ktu          FLOAT;
BEGIN
    _ktu_month_sum = (SELECT SUM(c_sum) FROM public.ktu k WHERE k.period_month = _month AND k.period_year = _year);
    _ktu_month_amount = (SELECT SUM(c_amount) FROM public.ktu k WHERE k.period_month = _month AND k.period_year = _year);
    _ktu_month_lines = (SELECT SUM(c_amount) FROM public.ktu k WHERE k.period_month = _month AND k.period_year = _year);
    _ktu_month_documents = (SELECT SUM(c_documents) FROM public.ktu k WHERE k.period_month = _month AND k.period_year = _year);
    SELECT INTO _fot
        CASE
-- ВОЗВРАЩАЕТ БОНУС СКЛАДА
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('warehouse')
                             THEN (SELECT ROUND((
                                (SELECT ROUND(
                                (SELECT (k.m_cash + k.m_bank + k.mir_cash + k.mir_bank + k.sad_cash + k.sad_bank)) * k.sklad_share / 100 / 100)
                                    FROM constants k
                                    WHERE period_year = _year
                                    AND period_month = _month) /
                                (SELECT SUM(ROUND((w.hours / c.work_hours * s.amount)::NUMERIC, 0))
                                      FROM salary s
                                               JOIN work_hours w ON s.user_id = w.user_id
                                          AND w.period_month = s.period_month
                                          AND w.period_year = s.period_year
                                               JOIN constants c ON s.period_month = c.period_month AND s.period_year = c.period_year
                                               JOIN users u ON s.user_id = u.id
                                      WHERE s.period_month = _month
                                        AND s.period_year = _year
                                        AND s.role = 'warehouse') *
                                     (SELECT ROUND((w.hours / c.work_hours * s.amount)::NUMERIC, 0)
                                      FROM salary s
                                               JOIN work_hours w ON s.user_id = w.user_id
                                          AND w.period_month = s.period_month
                                          AND w.period_year = s.period_year
                                               JOIN constants c ON s.period_month = c.period_month AND s.period_year = c.period_year
                                               JOIN users u ON s.user_id = u.id
                                      WHERE s.period_month = _month
                                        AND s.period_year = _year
                                        AND s.role = 'warehouse'
                                        AND u.id = _user_id))::NUMERIC))
--ВОЗВРАЩАЕТ БОНУС КОНСУЛЬТАНТА
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('consultant')
                             THEN (SELECT (SELECT (k.c_sum / _ktu_month_sum + k.c_documents / _ktu_month_documents) / 2
                                           FROM ktu k
                                           WHERE k.user_id = _user_id
                                             AND k.period_year = _year
                                             AND k.period_month = _month
                                             AND k.user_id <> 54) *
                                          (SELECT (k.m_cash + k.m_bank)) *
                                          k.m_share / 100 / 100
                                   FROM constants k
                                   WHERE period_year = _year
                                     AND period_month = _month)
--ВОЗВРАЩАЕТ БОНУС СБОРЩИКА
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('assembler')
                             THEN (SELECT floor((k.c_sum) / 100000) * 1000 + 6000
                                   FROM ktu k
                                   WHERE k.user_id = _user_id
                                     AND k.period_year = _year
                                     AND k.period_month = _month)
-- DJP
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('fixed_salary')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('hour_salary')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('adm_bonus')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('security')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('manager')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('cashier')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('shift_salary')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('countless')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('mir')
                             THEN (SELECT 123)
                         WHEN (SELECT get_role(_user_id, _month, _year)) IN ('regenbogen')
                             THEN (SELECT 123)
                         ELSE (SELECT 0)
                         END;
    RETURN _fot;
END;
$$;

ALTER FUNCTION compute_bonus(_user_id INTEGER, _month INTEGER, _year INTEGER) OWNER TO neuroplane;

SELECT public.compute_bonus(55, 5, 2021);