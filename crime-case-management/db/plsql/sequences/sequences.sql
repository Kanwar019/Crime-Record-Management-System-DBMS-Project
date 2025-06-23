-- 1. crime_seq
DROP SEQUENCE crime_seq;
CREATE SEQUENCE crime_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 2. cases_seq
DROP SEQUENCE cases_seq;
CREATE SEQUENCE cases_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 3. evidence_seq
DROP SEQUENCE evidence_seq;
CREATE SEQUENCE evidence_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 4. victim_seq
DROP SEQUENCE victim_seq;
CREATE SEQUENCE victim_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 5. trial_seq
DROP SEQUENCE trial_seq;
CREATE SEQUENCE trial_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 6. criminal_seq
DROP SEQUENCE criminal_seq;
CREATE SEQUENCE criminal_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 7. users_seq
DROP SEQUENCE users_seq;
CREATE SEQUENCE users_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 8. associated_with_seq
DROP SEQUENCE associated_with_seq;
CREATE SEQUENCE associated_with_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 9. references_to_seq
DROP SEQUENCE references_to_seq;
CREATE SEQUENCE references_to_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
