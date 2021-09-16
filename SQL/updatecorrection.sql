create or replace function updatecorrection(params json, _token uuid) returns json
    language plpgsql
as
$$
DECLARE
    _response JSON;
    _user_id bigint;
    _selected_user int;
    _dop int;
    _correction int;
    _month int;
    _year int;

BEGIN
    _user_id = get_user(_token); --ОБЯЗАТЕЛЬНАЯ СТРОКА
    _selected_user = requireint(params, 'selected_user');
    _dop = requireint(params, 'dop');
    _correction = requireint(params, 'correction');
    _month = requireint(params, 'month');
    _year = requireint(params, 'year');
    --UPDATE public.extra e SET dop_amount=_dop, amount = _correction WHERE e.user_id = _selected_user;

    INSERT INTO public.extra (id, user_id, amount, dop_amount, period_month, period_year) VALUES (DEFAULT, _selected_user, _dop, _correction, _month, _year)
    ON CONFLICT ON CONSTRAINT unique_userid_month_year DO
        UPDATE SET dop_amount=_dop, amount = _correction WHERE extra.user_id = _selected_user;
    SELECT to_json(a) INTO _response FROM (
                                               SELECT 'ВСЁ ЗАЕБЦА, ВСТАВИЛ ТЕБЕ ДОПЫ И КОРРЕКЦИЮ, НЕ ССЫ' as callback
                                           ) AS a;

    RETURN coalesce(_response,'[]');
END
$$;

alter function updatecorrection(json, uuid) owner to neuroplane;

select public.updatecorrection('{"correction":"789","dop":"456","month":7,"selected_user":62,"year":2021}'::json, '1b784146-e77e-431a-9f97-be7f9ff15bb5'::uuid);