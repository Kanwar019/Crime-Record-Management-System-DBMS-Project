-- 1) Create USERS if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE users (
      user_id    NUMBER         PRIMARY KEY,
      user_name  VARCHAR2(100)  NOT NULL,
      email      VARCHAR2(100)  UNIQUE NOT NULL,
      user_role  VARCHAR2(50),
      address    VARCHAR2(100),
      phone_no   VARCHAR2(15),
      password   VARCHAR2(30)   NOT NULL
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;  -- ignore ORA-00955
END;
/

-- 2) Create CRIME if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE crime (
      crime_id   NUMBER         PRIMARY KEY,
      crime_type VARCHAR2(50)   NOT NULL
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- 3) Create CRIMINAL if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE criminal (
      criminal_id        NUMBER         PRIMARY KEY,
      criminal_name      VARCHAR2(100)  NOT NULL,
      age                NUMBER,
      gender             VARCHAR2(10),
      criminal_history   VARCHAR2(100),
      crime_description  VARCHAR2(255),
      date_committed     DATE           NOT NULL,
      user_id            NUMBER         NOT NULL,
      reported_by        VARCHAR2(100),
      CONSTRAINT fk_crim_user FOREIGN KEY(user_id) REFERENCES users(user_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- 4) Create CASES if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE cases (
      case_id      NUMBER         PRIMARY KEY,
      crime_id     NUMBER         NOT NULL,
      date_opened  DATE           NOT NULL,
      date_closed  VARCHAR2(20),
      status       VARCHAR2(10)   NOT NULL,
      user_id      NUMBER         NOT NULL,
      CONSTRAINT fk_cases_crime FOREIGN KEY(crime_id) REFERENCES crime(crime_id),
      CONSTRAINT fk_cases_user  FOREIGN KEY(user_id)  REFERENCES users(user_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- 5) Create EVIDENCE if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE evidence (
      evidence_id       NUMBER         PRIMARY KEY,
      case_id           NUMBER         NOT NULL,
      evidence_type     VARCHAR2(50)   NOT NULL,
      description       VARCHAR2(255),
      storage_location  VARCHAR2(50),
      CONSTRAINT fk_evid_cases FOREIGN KEY(case_id) REFERENCES cases(case_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- 6) Create VICTIM if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE victim (
      victim_id        NUMBER         PRIMARY KEY,
      case_id          NUMBER         NOT NULL,
      victim_name      VARCHAR2(100)  NOT NULL,
      address          VARCHAR2(100),
      gender           VARCHAR2(10),
      victim_statement VARCHAR2(255),
      CONSTRAINT fk_victim_cases FOREIGN KEY(case_id) REFERENCES cases(case_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- 7) Create TRIAL if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE trial (
      trial_id     NUMBER         PRIMARY KEY,
      case_id      NUMBER         NOT NULL,
      court_name   VARCHAR2(50)   NOT NULL,
      judge_name   VARCHAR2(50),
      hearing_date DATE           NOT NULL,
      status       VARCHAR2(20),
      verdict      VARCHAR2(20),
      punishment   VARCHAR2(100),
      CONSTRAINT fk_trial_cases FOREIGN KEY(case_id) REFERENCES cases(case_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- 8) Create ASSOCIATED_WITH if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE associated_with (
      case_id      NUMBER         PRIMARY KEY,
      criminal_id  NUMBER         NOT NULL,
      CONSTRAINT fk_aw_cases    FOREIGN KEY(case_id)    REFERENCES cases(case_id),
      CONSTRAINT fk_aw_criminal FOREIGN KEY(criminal_id) REFERENCES criminal(criminal_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

-- 9) Create REFERENCES_TO if missing
BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE references_to (
      trial_id     NUMBER         PRIMARY KEY,
      criminal_id  NUMBER         NOT NULL,
      CONSTRAINT fk_rt_trial    FOREIGN KEY(trial_id)    REFERENCES trial(trial_id),
      CONSTRAINT fk_rt_criminal FOREIGN KEY(criminal_id) REFERENCES criminal(criminal_id)
    )';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/

