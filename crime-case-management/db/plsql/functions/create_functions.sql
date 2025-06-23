
-- 1) Get trial verdict
CREATE OR REPLACE FUNCTION get_trial_verdict(p_trial_id NUMBER)
  RETURN VARCHAR2
IS
  v_verdict VARCHAR2(20);
BEGIN
  SELECT verdict INTO v_verdict
  FROM trial
  WHERE trial_id = p_trial_id;
  RETURN v_verdict;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Pending';
END get_trial_verdict;
/

-- 2) Check if a case is closed
CREATE OR REPLACE FUNCTION is_case_closed(p_case_id NUMBER)
  RETURN VARCHAR2
IS
  v_status VARCHAR2(10);
BEGIN
  SELECT status INTO v_status
  FROM cases
  WHERE case_id = p_case_id;
  IF UPPER(v_status) = 'CLOSED' THEN
    RETURN 'YES';
  ELSE
    RETURN 'NO';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Case Not Found';
END is_case_closed;
/

-- 3) Get criminal age category
CREATE OR REPLACE FUNCTION get_criminal_age_category(p_criminal_id NUMBER)
  RETURN VARCHAR2
IS
  v_age NUMBER;
BEGIN
  SELECT age INTO v_age
  FROM criminal
  WHERE criminal_id = p_criminal_id;
  IF v_age < 18 THEN
    RETURN 'Minor';
  ELSIF v_age BETWEEN 18 AND 60 THEN
    RETURN 'Adult';
  ELSE
    RETURN 'Senior';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Age Unknown';
END get_criminal_age_category;
/

-- 4) Get open cases count for a user
CREATE OR REPLACE FUNCTION get_open_cases_count(p_user_id NUMBER)
  RETURN NUMBER
IS
  v_count NUMBER;
  v_user_exists NUMBER;
BEGIN
  -- Check if the user exists in the cases table
  SELECT COUNT(*) INTO v_user_exists
  FROM cases
  WHERE user_id = p_user_id;

  IF v_user_exists = 0 THEN
    -- Raise an error if the user does not exist
    RAISE_APPLICATION_ERROR(-20001, 'User does not exist.');
  END IF;

  -- Count the number of open cases for the existing user
  SELECT COUNT(*) INTO v_count
  FROM cases
  WHERE user_id = p_user_id
    AND UPPER(status) = 'OPEN';

  RETURN v_count;
END get_open_cases_count;

-- 5) Get case details for a given case ID
CREATE OR REPLACE FUNCTION get_crime_cases_count(p_crime_id NUMBER)
  RETURN NUMBER
IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM cases
  WHERE crime_id = p_crime_id;
  RETURN v_count;
END get_crime_cases_count;
/

-- 6) Get case details for a given case ID
CREATE OR REPLACE FUNCTION get_case_duration(p_case_id NUMBER)
  RETURN NUMBER
IS
  v_opened DATE;
  v_closed DATE;
BEGIN
  SELECT date_opened,
         date_closed
    INTO v_opened, v_closed
  FROM cases
  WHERE case_id = p_case_id;

  RETURN ABS(v_closed - v_opened);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END get_case_duration;

-- 7) Get case details for a given case ID
CREATE OR REPLACE FUNCTION get_evidence_details(p_case_id NUMBER)
  RETURN VARCHAR2
IS
  v_details VARCHAR2(32767) := ''; -- Use maximum size for VARCHAR2 in PL/SQL
BEGIN
  FOR rec IN (
    SELECT evidence_type, description, storage_location
    FROM evidence
    WHERE case_id = p_case_id
    ORDER BY evidence_type
  ) LOOP
    v_details := v_details ||
      'Type: ' || rec.evidence_type || 
      ', Description: ' || NVL(rec.description, 'N/A') ||
      ', Storage: ' || NVL(rec.storage_location, 'N/A') || CHR(10) || '---' || CHR(10);
    
    -- Check if the length exceeds the limit
    IF LENGTH(v_details) > 32767 THEN
      RETURN 'Result too large to display. Please refine your query.';
    END IF;
  END LOOP;

  IF v_details IS NULL OR LENGTH(v_details) = 0 THEN
    RETURN 'No Evidence Found for Case ID ' || p_case_id;
  ELSE
    RETURN v_details;
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RETURN 'Error retrieving evidence details: ' || SQLERRM;
END get_evidence_details;
/

-- 8) Get trial details for a given trial ID
CREATE OR REPLACE FUNCTION get_criminal_details(p_criminal_id IN NUMBER)
RETURN SYS_REFCURSOR
AS
  c_cursor SYS_REFCURSOR;
BEGIN
  OPEN c_cursor FOR
    SELECT * FROM criminal WHERE criminal_id = p_criminal_id;
  RETURN c_cursor;
END;
/

-- 9) Get trial details for a given trial ID
CREATE OR REPLACE FUNCTION calculate_trial_days(p_trial_id NUMBER)
  RETURN NUMBER
IS
  v_hearing_date     DATE;
  v_date_closed      DATE;
  v_end_date         DATE;
BEGIN
  SELECT t.hearing_date, c.date_closed
  INTO v_hearing_date, v_date_closed
  FROM trial t
  JOIN cases c ON t.case_id = c.case_id
  WHERE t.trial_id = p_trial_id;

  v_end_date := NVL(v_date_closed, SYSDATE);

  RETURN TRUNC(v_end_date) - TRUNC(v_hearing_date);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END calculate_trial_days;
/

-- 10) Get the most recent case ID for a user
CREATE OR REPLACE FUNCTION get_recent_case_by_trial_date(
  p_user_id IN NUMBER
) RETURN NUMBER
IS
  v_case_id   NUMBER := 0;
BEGIN
  
  SELECT c.case_id
    INTO v_case_id
    FROM cases c
    JOIN trial t
      ON c.case_id = t.case_id
   WHERE c.user_id = p_user_id
     AND t.hearing_date = (
       SELECT MAX(t2.hearing_date)
         FROM cases c2
         JOIN trial t2
           ON c2.case_id = t2.case_id
        WHERE c2.user_id = p_user_id
     );

  RETURN v_case_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END get_recent_case_by_trial_date;
/

-- 11) check if a criminal has any pending cases
CREATE OR REPLACE FUNCTION has_pending_case_for_criminal(
  p_criminal_id IN NUMBER
) RETURN CHAR
IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO v_count
    FROM associated_with aw
    JOIN cases c ON aw.case_id = c.case_id
   WHERE aw.criminal_id = p_criminal_id
     AND UPPER(c.status) = 'OPEN';
  RETURN CASE WHEN v_count > 0 THEN 'Y' ELSE 'N' END;
END has_pending_case_for_criminal;
/

-- 12) Get the number of cases for a user by status
CREATE OR REPLACE FUNCTION get_user_case_count_by_status(
  p_user_id IN NUMBER,
  p_status  IN VARCHAR2
) RETURN NUMBER
IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) 
    INTO v_count
    FROM cases
   WHERE user_id = p_user_id
     AND UPPER(status) = UPPER(p_status);

  RETURN v_count;
END get_user_case_count_by_status;
/

