create function get_role(_user_id integer, _month integer, _year integer) returns double precision
    language plpgsql
as
$$
DECLARE
    _sum float8;
BEGIN
    select c_sum from ktu where user_id = _user_id and period_month = _month and period_year = _year into _sum;
    return _sum;
END;
$$;

alter function get_role(integer, integer, integer) owner to neuroplane;