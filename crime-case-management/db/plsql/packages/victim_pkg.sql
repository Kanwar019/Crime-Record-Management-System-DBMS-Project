-- Package Specification
CREATE OR REPLACE PACKAGE victim_pkg AS
  PROCEDURE create_victim(
    p_victim_id IN victim.victim_id%TYPE,
    p_case_id IN victim.case_id%TYPE,
    p_name IN victim.name%TYPE,
    p_address IN victim.address%TYPE,
    p_gender IN victim.gender%TYPE,
    p_statement IN victim.statement%TYPE
  );

  FUNCTION read_all_victims RETURN SYS_REFCURSOR;

  PROCEDURE update_victim(
    p_victim_id IN victim.victim_id%TYPE,
    p_case_id IN victim.case_id%TYPE,
    p_name IN victim.name%TYPE,
    p_address IN victim.address%TYPE,
    p_gender IN victim.gender%TYPE,
    p_statement IN victim.statement%TYPE
  );

  PROCEDURE delete_victim(p_victim_id IN victim.victim_id%TYPE);
END victim_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY victim_pkg AS

  PROCEDURE create_victim(
    p_victim_id, p_case_id, p_name, p_address, p_gender, p_statement
  ) IS
  BEGIN
    INSERT INTO victim(victim_id, case_id, name, address, gender, statement)
    VALUES(p_victim_id, p_case_id, p_name, p_address, p_gender, p_statement);
    COMMIT;
  END create_victim;

  FUNCTION read_all_victims RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR 
      SELECT victim_id, case_id, name, address, gender, statement FROM victim;
    RETURN rc;
  END read_all_victims;

  PROCEDURE update_victim(
    p_victim_id, p_case_id, p_name, p_address, p_gender, p_statement
  ) IS
  BEGIN
    UPDATE victim
    SET case_id = p_case_id,
        name = p_name,
        address = p_address,
        gender = p_gender,
        statement = p_statement
    WHERE victim_id = p_victim_id;
    COMMIT;
  END update_victim;

  PROCEDURE delete_victim(p_victim_id) IS
  BEGIN
    DELETE FROM victim WHERE victim_id = p_victim_id;
    COMMIT;
  END delete_victim;

END victim_pkg;
/
