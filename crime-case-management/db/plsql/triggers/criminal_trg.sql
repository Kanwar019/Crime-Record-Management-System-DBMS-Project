CREATE OR REPLACE TRIGGER trg_criminal_before_ins_upd
  BEFORE INSERT OR UPDATE ON criminal
  FOR EACH ROW
BEGIN
  IF :NEW.criminal_name IS NULL
     OR LENGTH(TRIM(:NEW.criminal_name)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20021,
      'Criminal name cannot be empty');
  END IF;

  IF :NEW.age IS NOT NULL
     AND :NEW.age < 0 THEN
    RAISE_APPLICATION_ERROR(-20022,
      'Age cannot be negative');
  END IF;

  IF :NEW.date_committed > SYSDATE THEN
    RAISE_APPLICATION_ERROR(-20023,
      'Date committed cannot be in the future');
  END IF;
END;
/
