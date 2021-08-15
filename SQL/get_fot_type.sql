create or replace function get_fot_type(_user_id integer, _month integer, _year integer) returns int
    language plpgsql
as
$$
DECLARE
    _fot float;
BEGIN
    SELECT INTO _fot
        CASE
            WHEN (SELECT get_role(_user_id,_month,_year)) IN ('склад')
                THEN (select k.m_cash + k.m_bank + k.mir_cash + k.mir_bank + k.sad_cash + k.sad_bank
                from constants k where period_year = _year AND period_month = _month)
            WHEN (SELECT get_role(_user_id,_month,_year)) IN ('адм. бонус', 'посменная')
                THEN (select k.m_cash + k.m_bank + k.sad_cash + k.sad_bank
                from constants k where period_year = _year AND period_month = _month)
            ELSE (select 0)
        END;
    return _fot;
END;
$$;

alter function get_fot_type(integer, integer, integer) owner to neuroplane;

select get_fot_type(60,5,2021)