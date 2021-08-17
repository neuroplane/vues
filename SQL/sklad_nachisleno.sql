-- auto-generated definition
create or replace function sklad_nachisleno(_month integer, _year integer) returns integer
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

alter function get_fot_type(integer, integer) owner to neuroplane;

select public.individualzp('{"month":"06","report_date":"2021-6-1","selected_user":60,"year":"2021"}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);