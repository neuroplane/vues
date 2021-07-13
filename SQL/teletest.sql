DROP FUNCTION IF EXISTS neurotlg.teletest(JSON, UUID);
CREATE OR REPLACE FUNCTION neurotlg.teletest(params JSON, _token uuid)
    RETURNS JSON AS $$
DECLARE
    _response JSON;
    _user_id int;
    _input_text text;
    _input_int int;
    _input_timestamp timestamp;
    _input_date date;
    _input_bool bool;
BEGIN
    _user_id = (SELECT id from public.administrators where token = _token);
    _input_text = optionaltext(params, 'items');
    _input_bool = optionalboolean(params, 'inputbool');
    _input_date = optionaldate(params, 'inputdate');
    _input_int = optionalint(params, 'inputint');
    _input_timestamp = optionaldate(params, 'inputtimestamp');
    IF _user_id IS NULL THEN RAISE EXCEPTION 'ERROR HANDLER :: WRONG TOKEN' USING ERRCODE='ER403'; END IF;
    SELECT json_agg(a) INTO _response FROM (
      SELECT * from neurotlg.tlgtest
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

alter function neurotlg.teletest(json,uuid) owner to neuroplane;

select neurotlg.teletest('{"items":"hello"}'::JSON, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);
