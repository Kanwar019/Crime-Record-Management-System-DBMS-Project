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
