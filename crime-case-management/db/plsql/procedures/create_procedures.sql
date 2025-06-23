
--1) Add a new user
CREATE OR REPLACE PROCEDURE add_user(
  p_user_id    IN  users.user_id%TYPE,
  p_user_name  IN  users.user_name%TYPE,
  p_email      IN  users.email%TYPE,
  p_user_role  IN  users.user_role%TYPE DEFAULT NULL,
  p_address    IN  users.address%TYPE DEFAULT NULL,
  p_phone_no   IN  users.phone_no%TYPE DEFAULT NULL,
  p_password   IN  users.password%TYPE
) AS
BEGIN
  INSERT INTO users (
    user_id, user_name, email, user_role, address, phone_no, password
  ) VALUES (
    p_user_id, p_user_name, p_email, p_user_role, p_address, p_phone_no, p_password
  );

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_user;
/


--2) Add a new case
CREATE OR REPLACE PROCEDURE add_crime(
  p_crime_type  IN  VARCHAR2,
  p_crime_id    OUT NUMBER
) AS
BEGIN
  INSERT INTO crime (crime_id, crime_type)
  VALUES (NULL, p_crime_type)
  RETURNING crime_id INTO p_crime_id;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_crime;
/

--3) Add a new criminal
CREATE OR REPLACE PROCEDURE add_criminal(
  p_criminal_name     IN  VARCHAR2,
  p_age               IN  NUMBER       DEFAULT NULL,
  p_gender            IN  VARCHAR2     DEFAULT NULL,
  p_criminal_history  IN  VARCHAR2     DEFAULT NULL,
  p_crime_description IN  VARCHAR2     DEFAULT NULL,
  p_date_committed    IN  DATE,
  p_user_id           IN  NUMBER,
  p_reported_by       IN  VARCHAR2     DEFAULT NULL,
  p_criminal_id       OUT NUMBER
) AS
BEGIN
  INSERT INTO criminal (
    criminal_id, criminal_name, age, gender,
    criminal_history, crime_description, date_committed,
    user_id, reported_by
  ) VALUES (
    NULL, p_criminal_name, p_age, p_gender,
    p_criminal_history, p_crime_description, p_date_committed,
    p_user_id, p_reported_by
  )
  RETURNING criminal_id INTO p_criminal_id;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_criminal;
/

--4) Add a new case
CREATE OR REPLACE PROCEDURE add_case(
  p_crime_id    IN  NUMBER,
  p_date_opened IN  DATE,
  p_date_closed IN  VARCHAR2   DEFAULT NULL,
  p_status      IN  VARCHAR2,
  p_user_id     IN  NUMBER,
  p_case_id     OUT NUMBER
) AS
BEGIN
  INSERT INTO cases (
    case_id, crime_id, date_opened, date_closed, status, user_id
  ) VALUES (
    NULL, p_crime_id, p_date_opened, p_date_closed, p_status, p_user_id
  )
  RETURNING case_id INTO p_case_id;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_case;
/

--5) Add a new evidence
CREATE OR REPLACE PROCEDURE add_evidence(
  p_case_id          IN  NUMBER,
  p_evidence_type    IN  VARCHAR2,
  p_description      IN  VARCHAR2   DEFAULT NULL,
  p_storage_location IN  VARCHAR2   DEFAULT NULL,
  p_evidence_id      OUT NUMBER
) AS
BEGIN
  INSERT INTO evidence (
    evidence_id, case_id, evidence_type, description, storage_location
  ) VALUES (
    NULL, p_case_id, p_evidence_type, p_description, p_storage_location
  )
  RETURNING evidence_id INTO p_evidence_id;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_evidence;
/

--6) Add a new victim
CREATE OR REPLACE PROCEDURE add_victim(
  p_case_id          IN  NUMBER,
  p_victim_name      IN  VARCHAR2,
  p_address          IN  VARCHAR2   DEFAULT NULL,
  p_gender           IN  VARCHAR2   DEFAULT NULL,
  p_victim_statement IN  VARCHAR2,
  p_victim_id        OUT NUMBER
) AS
BEGIN
  INSERT INTO victim (
    victim_id, case_id, victim_name, address, gender, victim_statement
  ) VALUES (
    NULL, p_case_id, p_victim_name, p_address, p_gender, p_victim_statement
  )
  RETURNING victim_id INTO p_victim_id;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_victim;
/

--7) Add a new trial
CREATE OR REPLACE PROCEDURE add_trial(
  p_case_id    IN  NUMBER,
  p_court_name IN  VARCHAR2,
  p_judge_name IN  VARCHAR2   DEFAULT NULL,
  p_hearing_date IN DATE,
  p_status     IN  VARCHAR2   DEFAULT NULL,
  p_verdict    IN  VARCHAR2   DEFAULT NULL,
  p_punishment IN  VARCHAR2   DEFAULT NULL,
  p_trial_id   OUT NUMBER
) AS
BEGIN
  INSERT INTO trial (
    trial_id, case_id, court_name, judge_name,
    hearing_date, status, verdict, punishment
  ) VALUES (
    NULL, p_case_id, p_court_name, p_judge_name,
    p_hearing_date, p_status, p_verdict, p_punishment
  )
  RETURNING trial_id INTO p_trial_id;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_trial;
/

--8) Add a new association between a case and a criminal
CREATE OR REPLACE PROCEDURE add_associated_with(
  p_case_id     IN NUMBER,
  p_criminal_id IN NUMBER
) AS
BEGIN
  INSERT INTO associated_with (
    case_id, criminal_id
  ) VALUES (
    p_case_id, p_criminal_id
  );
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_associated_with;
/

--9) Add a new reference between a trial and a criminal
CREATE OR REPLACE PROCEDURE add_references_to(
  p_trial_id     IN NUMBER,
  p_criminal_id  IN NUMBER
) AS
BEGIN
  INSERT INTO references_to (
    trial_id, criminal_id
  ) VALUES (
    p_trial_id, p_criminal_id
  );
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END add_references_to;
/



