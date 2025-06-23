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
