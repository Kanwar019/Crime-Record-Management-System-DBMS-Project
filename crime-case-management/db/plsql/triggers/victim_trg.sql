CREATE OR REPLACE TRIGGER trg_victim_before_ins_upd
  BEFORE INSERT OR UPDATE ON victim
  FOR EACH ROW
BEGIN
  IF :NEW.victim_name IS NULL
     OR LENGTH(TRIM(:NEW.victim_name)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20051,
      'Victim name cannot be empty');
  END IF;

  IF :NEW.victim_statement IS NULL
     OR LENGTH(TRIM(:NEW.victim_statement)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20052,
      'Victim statement cannot be empty');
  END IF;
END;
/
