-- Package Specification
CREATE OR REPLACE PACKAGE criminal_pkg AS
  PROCEDURE create_criminal(
    p_criminal_id IN criminal.criminal_id%TYPE,
    p_name IN criminal.criminal_name%TYPE,
    p_age IN criminal.age%TYPE,
    p_gender IN criminal.gender%TYPE,
    p_history IN criminal.criminal_history%TYPE,
    p_descr IN criminal.crime_description%TYPE,
    p_date IN VARCHAR2,
    p_uid IN criminal.user_id%TYPE,
    p_reported_by IN criminal.reported_by%TYPE
  );

  FUNCTION read_all_criminals RETURN SYS_REFCURSOR;

  PROCEDURE update_criminal(
    p_criminal_id IN criminal.criminal_id%TYPE,
    p_name IN criminal.criminal_name%TYPE,
    p_age IN criminal.age%TYPE,
    p_gender IN criminal.gender%TYPE,
    p_history IN criminal.criminal_history%TYPE,
    p_descr IN criminal.crime_description%TYPE,
    p_date IN VARCHAR2,
    p_uid IN criminal.user_id%TYPE,
    p_reported_by IN criminal.reported_by%TYPE
  );

  PROCEDURE delete_criminal(p_criminal_id IN criminal.criminal_id%TYPE);
END criminal_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY criminal_pkg AS

  PROCEDURE create_criminal(
    p_criminal_id, p_name, p_age, p_gender, p_history, p_descr, p_date, p_uid, p_reported_by
  ) IS
  BEGIN
    INSERT INTO criminal(
      criminal_id, criminal_name, age, gender, criminal_history, crime_description, date_committed, user_id, reported_by
    ) VALUES (
      p_criminal_id, p_name, p_age, p_gender, p_history, p_descr, TO_DATE(p_date,'DD-MM-YYYY'), p_uid, p_reported_by
    );
    COMMIT;
  END create_criminal;

  FUNCTION read_all_criminals RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR
      SELECT 
        criminal_id, criminal_name, age, gender, criminal_history, crime_description,
        TO_CHAR(date_committed, 'DD-MM-YYYY') AS date_committed, user_id, reported_by
      FROM criminal;
    RETURN rc;
  END read_all_criminals;

  PROCEDURE update_criminal(
    p_criminal_id, p_name, p_age, p_gender, p_history, p_descr, p_date, p_uid, p_reported_by
  ) IS
  BEGIN
    UPDATE criminal
    SET 
      criminal_name = p_name,
      age = p_age,
      gender = p_gender,
      criminal_history = p_history,
      crime_description = p_descr,
      date_committed = TO_DATE(p_date,'DD-MM-YYYY'),
      user_id = p_uid,
      reported_by = p_reported_by
    WHERE criminal_id = p_criminal_id;
    COMMIT;
  END update_criminal;

  PROCEDURE delete_criminal(p_criminal_id) IS
  BEGIN
    DELETE FROM criminal WHERE criminal_id = p_criminal_id;
    COMMIT;
  END delete_criminal;

END criminal_pkg;
/
