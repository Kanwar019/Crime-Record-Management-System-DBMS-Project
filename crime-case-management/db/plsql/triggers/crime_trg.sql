CREATE OR REPLACE TRIGGER trg_crime_before_ins_upd
  BEFORE INSERT OR UPDATE ON crime
  FOR EACH ROW
BEGIN
  IF :NEW.crime_type IS NULL
     OR LENGTH(TRIM(:NEW.crime_type)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20011,
      'Crime type cannot be empty');
  END IF;
END;
/
