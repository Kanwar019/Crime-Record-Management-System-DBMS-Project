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
    IF SQLCODE != -955 THEN RAISE; END IF;
END;
/
