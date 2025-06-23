-- Package Specification
CREATE OR REPLACE PACKAGE crime_pkg AS
  PROCEDURE create_crime(
    p_crime_id IN crime.crime_id%TYPE,
    p_crime_type IN crime.crime_type%TYPE
  );

  FUNCTION read_all_crimes RETURN SYS_REFCURSOR;

  PROCEDURE update_crime(
    p_crime_id IN crime.crime_id%TYPE,
    p_crime_type IN crime.crime_type%TYPE
  );

  PROCEDURE delete_crime(p_crime_id IN crime.crime_id%TYPE);
END crime_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY crime_pkg AS

  PROCEDURE create_crime(
    p_crime_id IN crime.crime_id%TYPE,
    p_crime_type IN crime.crime_type%TYPE
  ) IS
  BEGIN
    INSERT INTO crime(crime_id, crime_type)
    VALUES(p_crime_id, p_crime_type);
    COMMIT;
  END create_crime;

  FUNCTION read_all_crimes RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR
      SELECT crime_id, crime_type FROM crime;
    RETURN rc;
  END read_all_crimes;

  PROCEDURE update_crime(
    p_crime_id IN crime.crime_id%TYPE,
    p_crime_type IN crime.crime_type%TYPE
  ) IS
  BEGIN
    UPDATE crime
       SET crime_type = p_crime_type
     WHERE crime_id = p_crime_id;
    COMMIT;
  END update_crime;

  PROCEDURE delete_crime(p_crime_id IN crime.crime_id%TYPE) IS
  BEGIN
    DELETE FROM crime WHERE crime_id = p_crime_id;
    COMMIT;
  END delete_crime;

END crime_pkg;
/
