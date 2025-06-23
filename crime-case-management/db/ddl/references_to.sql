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
