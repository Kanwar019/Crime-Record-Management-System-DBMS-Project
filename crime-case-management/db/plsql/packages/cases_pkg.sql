-- Package Specification
CREATE OR REPLACE PACKAGE cases_pkg AS
  PROCEDURE create_case(
    p_case_id    IN cases.case_id%TYPE,
    p_crime_id   IN cases.crime_id%TYPE,
    p_date_open  IN VARCHAR2,
    p_date_close IN VARCHAR2,
    p_status     IN cases.status%TYPE,
    p_user_id    IN cases.user_id%TYPE
  );

  FUNCTION read_all_cases RETURN SYS_REFCURSOR;

  PROCEDURE update_case(
    p_case_id    IN cases.case_id%TYPE,
    p_crime_id   IN cases.crime_id%TYPE,
    p_date_open  IN VARCHAR2,
    p_date_close IN VARCHAR2,
    p_status     IN cases.status%TYPE,
    p_user_id    IN cases.user_id%TYPE
  );

  PROCEDURE delete_case(p_case_id IN cases.case_id%TYPE);
END cases_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY cases_pkg AS

  PROCEDURE create_case(
    p_case_id    IN cases.case_id%TYPE,
    p_crime_id   IN cases.crime_id%TYPE,
    p_date_open  IN VARCHAR2,
    p_date_close IN VARCHAR2,
    p_status     IN cases.status%TYPE,
    p_user_id    IN cases.user_id%TYPE
  ) IS
  BEGIN
    INSERT INTO cases(
      case_id, crime_id, date_opened, date_closed, status, user_id
    )
    VALUES (
      p_case_id, p_crime_id, TO_DATE(p_date_open, 'DD-MM-YYYY'),
      p_date_close, p_status, p_user_id
    );
    COMMIT;
  END create_case;

  FUNCTION read_all_cases RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR
      SELECT case_id, crime_id, TO_CHAR(date_opened, 'DD-MM-YYYY') AS date_opened,
             date_closed, status, user_id
        FROM cases;
    RETURN rc;
  END read_all_cases;

  PROCEDURE update_case(
    p_case_id    IN cases.case_id%TYPE,
    p_crime_id   IN cases.crime_id%TYPE,
    p_date_open  IN VARCHAR2,
    p_date_close IN VARCHAR2,
    p_status     IN cases.status%TYPE,
    p_user_id    IN cases.user_id%TYPE
  ) IS
  BEGIN
    UPDATE cases
       SET crime_id   = p_crime_id,
           date_opened = TO_DATE(p_date_open, 'DD-MM-YYYY'),
           date_closed = p_date_close,
           status      = p_status,
           user_id     = p_user_id
     WHERE case_id = p_case_id;
    COMMIT;
  END update_case;

  PROCEDURE delete_case(p_case_id IN cases.case_id%TYPE) IS
  BEGIN
    DELETE FROM cases WHERE case_id = p_case_id;
    COMMIT;
  END delete_case;

END cases_pkg;
/
