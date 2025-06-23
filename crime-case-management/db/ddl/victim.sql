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
