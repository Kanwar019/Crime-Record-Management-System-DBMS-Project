BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE trial (
      trial_id     NUMBER         PRIMARY KEY,
      case_id      NUMBER         NOT NULL,
      court_name   VARCHAR2(50)   NOT NULL,
      judge_name   VARCHAR2(50),
      hearing_date DATE           NOT NULL,
      verdict      VARCHAR2(20),
      CONSTRAINT fk_trial_cases FOREIGN KEY(case_id) REFERENCES cases(case_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/
