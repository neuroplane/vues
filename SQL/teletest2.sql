DROP FUNCTION IF EXISTS neurotlg.docselection(JSON, UUID);
CREATE OR REPLACE FUNCTION neurotlg.docselection(params JSON, _token uuid)
    RETURNS JSON AS $$
DECLARE
    _response JSON;
    _user_id int;
    _input_text text;
    _input_int int;
    _input_timestamp timestamp;
    _input_date date;
    _input_bool bool;
    _user_selected int;
    _user_fio text;
    _user_ru_passport text;
    _user_foreign_passport text;
    _input_document text;
BEGIN
    _user_id = (SELECT id from public.administrators where token = _token);
    _user_selected = requireint(params, 'userid');
    _input_document = requiretext(params, 'document');
    _input_text = optionaltext(params, 'items');
    _input_bool = optionalboolean(params, 'inputbool');
    _input_date = optionaldate(params, 'inputdate');
    _input_int = optionalint(params, 'inputint');
    _input_timestamp = optionaldate(params, 'inputtimestamp');
    IF _user_id IS NULL THEN RAISE EXCEPTION 'ERROR HANDLER :: WRONG TOKEN' USING ERRCODE='ER403'; END IF;
    SELECT to_json(a) INTO _response FROM (
      SELECT
            _input_document from neurotlg.people where id = _user_selected
             --(SELECT last_name || chr(10) || first_name || ' ' || patronymic as ФИО), (SELECT ru_passport as паспорт), people.ru_passport_file as ru_passport_url, (SELECT foreign_passport as загран) from neurotlg.people where id = _user_selected
    ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

alter function neurotlg.docselection(json,uuid) owner to neuroplane;

select neurotlg.docselection('{"document":"passport","userid":1}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);