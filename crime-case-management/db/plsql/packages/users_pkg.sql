-- Package Specification
CREATE OR REPLACE PACKAGE users_pkg AS
  PROCEDURE create_user(
    p_user_id IN users.user_id%TYPE,
    p_name IN users.name%TYPE,
    p_email IN users.email%TYPE,
    p_user_role IN users.user_role%TYPE,
    p_address IN users.address%TYPE,
    p_phone_no IN users.phone_no%TYPE,
    p_password IN users.password%TYPE
  );

  FUNCTION read_all_users RETURN SYS_REFCURSOR;

  PROCEDURE update_user(
    p_user_id IN users.user_id%TYPE,
    p_name IN users.name%TYPE,
    p_email IN users.email%TYPE,
    p_user_role IN users.user_role%TYPE,
    p_address IN users.address%TYPE,
    p_phone_no IN users.phone_no%TYPE,
    p_password IN users.password%TYPE
  );

  PROCEDURE delete_user(p_user_id IN users.user_id%TYPE);
END users_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY users_pkg AS

  PROCEDURE create_user(
    p_user_id, p_name, p_email, p_user_role, p_address, p_phone_no, p_password
  ) IS
  BEGIN
    INSERT INTO users(user_id, name, email, user_role, address, phone_no, password)
    VALUES(p_user_id, p_name, p_email, p_user_role, p_address, p_phone_no, p_password);
    COMMIT;
  END create_user;

  FUNCTION read_all_users RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR 
      SELECT user_id, name, email, user_role, address, phone_no FROM users;
    RETURN rc;
  END read_all_users;

  PROCEDURE update_user(
    p_user_id, p_name, p_email, p_user_role, p_address, p_phone_no, p_password
  ) IS
  BEGIN
    UPDATE users
    SET name = p_name,
        email = p_email,
        user_role = p_user_role,
        address = p_address,
        phone_no = p_phone_no,
        password = p_password
    WHERE user_id = p_user_id;
    COMMIT;
  END update_user;

  PROCEDURE delete_user(p_user_id) IS
  BEGIN
    DELETE FROM users WHERE user_id = p_user_id;
    COMMIT;
  END delete_user;

END users_pkg;
/
