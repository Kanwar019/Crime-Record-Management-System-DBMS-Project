-- Package Specification
CREATE OR REPLACE PACKAGE trial_pkg AS
  PROCEDURE create_trial(
    p_trial_id IN trial.trial_id%TYPE,
    p_case_id IN trial.case_id%TYPE,
    p_court IN trial.court_name%TYPE,
    p_judge IN trial.judge_name%TYPE,
    p_date IN VARCHAR2,
    p_verdict IN trial.verdict%TYPE
  );

  FUNCTION read_all_trials RETURN SYS_REFCURSOR;

  PROCEDURE update_trial(
    p_trial_id IN trial.trial_id%TYPE,
    p_case_id IN trial.case_id%TYPE,
    p_court IN trial.court_name%TYPE,
    p_judge IN trial.judge_name%TYPE,
    p_date IN VARCHAR2,
    p_verdict IN trial.verdict%TYPE
  );

  PROCEDURE delete_trial(p_trial_id IN trial.trial_id%TYPE);
END trial_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY trial_pkg AS

  PROCEDURE create_trial(
    p_trial_id, p_case_id, p_court, p_judge, p_date, p_verdict
  ) IS
  BEGIN
    INSERT INTO trial(trial_id, case_id, court_name, judge_name, hearing_date, verdict)
    VALUES(p_trial_id, p_case_id, p_court, p_judge, TO_DATE(p_date, 'DD-MM-YYYY'), p_verdict);
    COMMIT;
  END create_trial;

  FUNCTION read_all_trials RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR 
      SELECT trial_id, case_id, court_name, judge_name, 
             TO_CHAR(hearing_date, 'DD-MM-YYYY') hearing_date, verdict
        FROM trial;
    RETURN rc;
  END read_all_trials;

  PROCEDURE update_trial(
    p_trial_id, p_case_id, p_court, p_judge, p_date, p_verdict
  ) IS
  BEGIN
    UPDATE trial
    SET case_id = p_case_id,
        court_name = p_court,
        judge_name = p_judge,
        hearing_date = TO_DATE(p_date, 'DD-MM-YYYY'),
        verdict = p_verdict
    WHERE trial_id = p_trial_id;
    COMMIT;
  END update_trial;

  PROCEDURE delete_trial(p_trial_id) IS
  BEGIN
    DELETE FROM trial WHERE trial_id = p_trial_id;
    COMMIT;
  END delete_trial;

END trial_pkg;
/
