CREATE OR REPLACE TRIGGER trg_evidence_before_ins_upd
  BEFORE INSERT OR UPDATE ON evidence
  FOR EACH ROW
BEGIN
  IF :NEW.evidence_type IS NULL
     OR LENGTH(TRIM(:NEW.evidence_type)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20041,
      'Evidence type cannot be empty');
  END IF;

  IF :NEW.storage_location IS NULL
     OR LENGTH(TRIM(:NEW.storage_location)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20042,
      'Storage location cannot be empty');
  END IF;
END;
/
