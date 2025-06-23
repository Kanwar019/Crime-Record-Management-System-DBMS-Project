-- ============================================================
-- MASTER SCRIPT TO SETUP THE CRIME CASE MANAGEMENT DATABASE
-- ============================================================

-- Step 1: Create all Tables (DDL)
@../db/ddl/create_tables.sql

-- Step 2: Create all Sequences
@../db/plsql/sequences/sequences.sql

-- Step 3: Insert initial data (DML)
@../db/dml/insert_data.sql

-- Step 4: Create Functions (if any)
@../db/plsql/functions/create_functions.sql

-- Step 5: Create Procedures
@../db/plsql/procedures/create_procedures.sql

-- Step 6: Create Packages
@../db/plsql/packages/cases_pkg.sql
@../db/plsql/packages/crime_pkg.sql
@../db/plsql/packages/criminal_pkg.sql
@../db/plsql/packages/evidence_pkg.sql
@../db/plsql/packages/trial_pkg.sql
@../db/plsql/packages/users_pkg.sql
@../db/plsql/packages/victim_pkg.sql

-- Step 7: Create Triggers
@../db/plsql/triggers/associated_with_trg.sql
@../db/plsql/triggers/cases_trg.sql
@../db/plsql/triggers/crime_trg.sql
@../db/plsql/triggers/criminal_trg.sql
@../db/plsql/triggers/evidence_trg.sql
@../db/plsql/triggers/references_to_trg.sql
@../db/plsql/triggers/trial_trg.sql
@../db/plsql/triggers/users_trg.sql
@../db/plsql/triggers/victim_trg.sql

-- ============================================================
-- DONE
-- ============================================================
