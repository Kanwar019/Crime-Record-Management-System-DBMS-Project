CREATE OR REPLACE TRIGGER trg_associated_with_before_ins
  BEFORE INSERT ON associated_with
  FOR EACH ROW
DECLARE
  l_count NUMBER;
BEGIN
  -- Count matching criminal_id in the CRIMINAL table
  SELECT COUNT(*) 
    INTO l_count
    FROM criminal
   WHERE criminal_id = :NEW.criminal_id;
  
  -- If none found, raise an error
  IF l_count = 0 THEN
    RAISE_APPLICATION_ERROR(
      -20071,
      'Associated criminal does not exist'
    );
  END IF;
END;
/
