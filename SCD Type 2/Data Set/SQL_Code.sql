-- 1. Check if the source table (SRC_EMP_SCD2) exists and drop it if it does
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SRC_EMP_SCD2';
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Ignore the error if the table doesn't exist
END;
/


-- 2. Create the SRC_EMP_SCD2 table (Source Table)
CREATE TABLE SRC_EMP_SCD2 (
    EMPLOYEE_ID     NUMBER(6) NOT NULL,           -- Unique identifier for each employee
    FIRST_NAME      VARCHAR2(20),                 -- First name of the employee
    LAST_NAME       VARCHAR2(25),                 -- Last name of the employee
    PHONE_NUMBER    VARCHAR2(20),                 -- Phone number of the employee
    HIRE_DATE       DATE,                          -- The date the employee was hired
    SALARY          NUMBER(8),                    -- Salary of the employee
    DEPARTMENT      VARCHAR2(20),                 -- Department the employee works in
    SUBMISSION_DATE DATE,                          -- Date the record is being submitted/updated
    CONSTRAINT EMPLOYEE_PK_NEW PRIMARY KEY (EMPLOYEE_ID)  -- Changed constraint name to EMPLOYEE_PK_NEW
);

-- 3. Insert sample data into the source table with submission_date
INSERT INTO SRC_EMP_SCD2 (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, DEPARTMENT, SUBMISSION_DATE)
VALUES (1, 'JOHN', 'DOE', '123-456-7890', 5000, TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'HR', TO_DATE('2023-07-01', 'YYYY-MM-DD'));

INSERT INTO SRC_EMP_SCD2 (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, DEPARTMENT, SUBMISSION_DATE)
VALUES (2, 'JANE', 'SMITH', '234-567-8901', 6000, TO_DATE('2021-06-15', 'YYYY-MM-DD'), 'IT', TO_DATE('2023-07-01', 'YYYY-MM-DD'));

INSERT INTO SRC_EMP_SCD2 (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, DEPARTMENT, SUBMISSION_DATE)
VALUES (3, 'ALICE', 'JOHNSON', '345-678-9012', 7000, TO_DATE('2020-03-20', 'YYYY-MM-DD'), 'MARKETING', TO_DATE('2023-07-01', 'YYYY-MM-DD'));

INSERT INTO SRC_EMP_SCD2 (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, DEPARTMENT, SUBMISSION_DATE)
VALUES (4, 'BOB', 'BROWN', '456-789-0123', 5500, TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'SALES', TO_DATE('2023-07-01', 'YYYY-MM-DD'));

INSERT INTO SRC_EMP_SCD2 (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, DEPARTMENT, SUBMISSION_DATE)
VALUES (5, 'CAROL', 'DAVIS', '567-890-1234', 6500, TO_DATE('2022-11-05', 'YYYY-MM-DD'), 'FINANCE', TO_DATE('2023-07-01', 'YYYY-MM-DD'));


-- 4. Select data from the SRC_EMP_SCD2 table (Source Table) to view the contents
SELECT * FROM SRC_EMP_SCD2;
/


-- 1. Check if the target table (TGT_EMP_SCD2) exists and drop it if it does
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TGT_EMP_SCD2';
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Ignore the error if the table doesn't exist
END;
/


-- 2. Create the TGT_EMP_SCD2 table (Target Table) without a constraint
CREATE TABLE TGT_EMP_SCD2 (
    emp_key        NUMBER(6),                    -- Surrogate key, manually entered (not auto-generated)
    employee_id    NUMBER(6) NOT NULL,           -- Unique identifier for each employee
    full_name      VARCHAR2(45 BYTE),            -- Full name (concatenation of first name and last name)
    phone_number   VARCHAR2(20 BYTE),            -- Employee's phone number
    hire_date      DATE,                         -- The date the employee was hired
    salary         NUMBER(8, 2),                 -- Employee's salary
    department     VARCHAR2(20 BYTE),            -- Department the employee works in
    start_date     DATE,                         -- The date when the record became effective
    end_date       DATE,                         -- The date when the record was superseded (NULL for active records)
    current_flag   CHAR(1)                       -- Indicates if the record is "active" or "inactive" (no default value)
);

-- 3. Select data from the TGT_EMP_SCD2 table (Target Table) to view the contents
SELECT * FROM TGT_EMP_SCD2;
