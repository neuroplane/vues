DROP FUNCTION IF EXISTS getusers(JSON, UUID);
CREATE OR REPLACE FUNCTION getusers(params JSON, _token uuid)
RETURNS JSON AS $$
DECLARE
    _response JSON;
    _limit INTEGER;
    _something TEXT;
BEGIN
    _limit = requireInt(params, 'limit');
    _something = optionalText(params, 'something');

    SELECT json_agg(a) INTO _response FROM (
        SELECT * from  users
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

SELECT * FROM getusers('{"limit":25}'::JSON, null);
