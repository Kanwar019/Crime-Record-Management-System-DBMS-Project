CREATE OR REPLACE TRIGGER trg_trial_before_ins_upd
  BEFORE INSERT OR UPDATE ON trial
  FOR EACH ROW
DECLARE
  v_case_open_date DATE;
BEGIN
  -- Fetch the case’s open date into a local variable
  SELECT date_opened
    INTO v_case_open_date
    FROM cases
   WHERE case_id = :NEW.case_id;

  -- Business rule: hearing_date must not precede the case’s open date
  IF :NEW.hearing_date < v_case_open_date THEN
    RAISE_APPLICATION_ERROR(
      -20062,
      'Hearing date cannot be before case open date'
    );
  END IF;
END;
/
