select get_trial_verdict(502) from dual;

select IS_CASE_CLOSED(201) from dual;

select calculate_case_days_from_trial(513) from dual;

select GET_CRIMINAL_AGE_CATEGORY(601) from dual;

select GET_OPEN_CASES_COUNT(9) from dual;

select GET_CRIME_CASES_COUNT(102) from dual;

select GET_CASE_DURATION(210) from dual;

select GET_EVIDENCE_DETAILS(202) from dual;

select GET_CRIMINAL_DETAILS(602) from dual;

BEGIN
  insert into users values (1, NULL , 'test@example.com', 'admin', '123 Main St', '1234567890', 'password123');
END;

select calculate_trial_days(507) from dual;

BEGIN ADD_USER(1, 'Kanwar' , 'test@example.com', 'admin', '123 Main St', '1234567890', 'password123');
 END;

select GET_RECENT_CASE_BY_TRIAL_DATE(12) from dual;

select has_pending_case_for_criminal(607) from dual;

Select get_user_case_count_by_status(9, 'open') from dual;

BEGIN
INSERT INTO evidence  VALUES (101,'Forensic Report','','Locker A-12');
END;
/

BEGIN
add_user(1, 'John Doe', 'john.doe@example.com', 'user', '123 Main St', '1234567890', 'password123');
END;
