DROP FUNCTION IF EXISTS reply();
CREATE OR REPLACE FUNCTION reply()
    RETURNS JSON AS $$
DECLARE
    _response JSON;
BEGIN
    SELECT to_json(a) INTO _response FROM (
        SELECT 'OK' as reply
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

alter function reply() owner to neuroplane;

select reply();
