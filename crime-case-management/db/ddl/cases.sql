BEGIN
  EXECUTE IMMEDIATE '
    CREATE TABLE cases (
      case_id      NUMBER         PRIMARY KEY,
      crime_id     NUMBER         NOT NULL,
      date_opened  DATE           NOT NULL,
      date_closed  DATE,
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
