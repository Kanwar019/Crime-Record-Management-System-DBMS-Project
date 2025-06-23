CREATE OR REPLACE TRIGGER trg_references_to_before_ins
  BEFORE INSERT ON references_to
  FOR EACH ROW
DECLARE
  l_count NUMBER;
BEGIN
  -- Count matching trial_id in the TRIAL table
  SELECT COUNT(*) 
    INTO l_count
    FROM trial
   WHERE trial_id = :NEW.trial_id;
  
  -- If none found, raise an error
  IF l_count = 0 THEN
    RAISE_APPLICATION_ERROR(
      -20081,
      'Referenced trial does not exist'
    );
  END IF;
END;
/
