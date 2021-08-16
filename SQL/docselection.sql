DROP FUNCTION IF EXISTS neurotlg.docselection(JSON, UUID);
CREATE OR REPLACE FUNCTION neurotlg.docselection(params JSON, _token uuid)
    RETURNS JSON AS $$
DECLARE
    _response JSON;
    _user_id int;
    _name_id text;
    _input_document text;
    _document_response text;
BEGIN
    _user_id = (SELECT id from public.administrators where token = _token);
    _name_id = requiretext(params, 'userid');
    _input_document = requiretext(params, 'document');
    IF _user_id IS NULL THEN RAISE EXCEPTION 'ERROR HANDLER :: WRONG TOKEN' USING ERRCODE='ER403'; END IF;
    EXECUTE 'select ' || _input_document || ' from neurotlg.people WHERE  people.name_id = ' || _name_id INTO _document_response;
    --IF _document_response = 'None' THEN _document_response = 'Такого документа нет';
    SELECT to_json(a) INTO _response FROM (
        SELECT _document_response as ДОКУМЕНТ
                                          ) AS a;

    RETURN coalesce(_response,'[]');
END
$$ LANGUAGE 'plpgsql';

alter function neurotlg.docselection(json,uuid) owner to neuroplane;

select neurotlg.docselection('{"document":"ru_passport","userid":"'boyarkinaaa'"}'::json, '11609376-ff57-401e-88a4-53f4c0904fdb'::uuid);