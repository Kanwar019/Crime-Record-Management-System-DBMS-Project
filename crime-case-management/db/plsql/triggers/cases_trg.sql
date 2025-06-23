CREATE OR REPLACE TRIGGER trg_cases_before_ins_upd
  BEFORE INSERT OR UPDATE ON cases
  FOR EACH ROW
BEGIN
  -- status must be one of OPEN, CLOSED, PENDING
  IF :NEW.status NOT IN ('OPEN','CLOSED','PENDING') THEN
    RAISE_APPLICATION_ERROR(-20031,
      'Status must be OPEN, CLOSED or PENDING');
  END IF;

  -- if date_closed is provided, it cannot be before date_opened
  IF :NEW.date_closed IS NOT NULL
     AND TO_DATE(:NEW.date_closed, 'YYYY-MM-DD')
         < :NEW.date_opened THEN
    RAISE_APPLICATION_ERROR(-20032,
      'Date closed cannot be before date opened');
  END IF;
END;
/
