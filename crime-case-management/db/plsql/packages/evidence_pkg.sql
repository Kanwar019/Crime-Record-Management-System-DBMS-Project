-- Package Specification
CREATE OR REPLACE PACKAGE evidence_pkg AS
  PROCEDURE create_evidence(
    p_evid_id IN evidence.evidence_id%TYPE,
    p_case_id IN evidence.case_id%TYPE,
    p_type IN evidence.evidence_type%TYPE,
    p_desc IN evidence.description%TYPE,
    p_location IN evidence.storage_location%TYPE
  );

  FUNCTION read_all_evidence RETURN SYS_REFCURSOR;

  PROCEDURE update_evidence(
    p_evid_id IN evidence.evidence_id%TYPE,
    p_case_id IN evidence.case_id%TYPE,
    p_type IN evidence.evidence_type%TYPE,
    p_desc IN evidence.description%TYPE,
    p_location IN evidence.storage_location%TYPE
  );

  PROCEDURE delete_evidence(p_evid_id IN evidence.evidence_id%TYPE);
END evidence_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY evidence_pkg AS

  PROCEDURE create_evidence(
    p_evid_id, p_case_id, p_type, p_desc, p_location
  ) IS
  BEGIN
    INSERT INTO evidence(evidence_id, case_id, evidence_type, description, storage_location)
    VALUES(p_evid_id, p_case_id, p_type, p_desc, p_location);
    COMMIT;
  END create_evidence;

  FUNCTION read_all_evidence RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR 
      SELECT evidence_id, case_id, evidence_type, description, storage_location FROM evidence;
    RETURN rc;
  END read_all_evidence;

  PROCEDURE update_evidence(
    p_evid_id, p_case_id, p_type, p_desc, p_location
  ) IS
  BEGIN
    UPDATE evidence
    SET case_id = p_case_id,
        evidence_type = p_type,
        description = p_desc,
        storage_location = p_location
    WHERE evidence_id = p_evid_id;
    COMMIT;
  END update_evidence;

  PROCEDURE delete_evidence(p_evid_id) IS
  BEGIN
    DELETE FROM evidence WHERE evidence_id = p_evid_id;
    COMMIT;
  END delete_evidence;

END evidence_pkg;
/
