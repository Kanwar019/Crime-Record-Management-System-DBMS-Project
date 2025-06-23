CREATE OR REPLACE TRIGGER trg_users_validations
  BEFORE INSERT OR UPDATE ON users
  FOR EACH ROW
BEGIN
  IF :NEW.user_name IS NULL
     OR LENGTH(TRIM(:NEW.user_name)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20001,
      'User name cannot be empty');
  END IF;

  IF :NEW.email IS NULL
     OR LENGTH(TRIM(:NEW.email)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20002,
      'Email cannot be empty');
  END IF;

  IF :NEW.password IS NULL
     OR LENGTH(TRIM(:NEW.password)) = 0 THEN
    RAISE_APPLICATION_ERROR(-20003,
      'Password cannot be empty');
  END IF;

  -- simple email format check
  IF INSTR(:NEW.email, '@') = 0 THEN
    RAISE_APPLICATION_ERROR(-20004,
      'Email must contain an "@" character');
  END IF;
END;
/
