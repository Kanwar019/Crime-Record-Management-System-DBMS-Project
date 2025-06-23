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
