-- 1. Check if the source table (EMPLOYEE_INFO) exists and drop it if it does
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEE_INFO PURGE';
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Ignore the error if the table doesn't exist
END;
/

-- 2. Create the source table (Source Table) with modified column size for COMMISSION_PCT to support decimal values
CREATE TABLE EMPLOYEE_INFO (
    EMPLOYEE_ID     NUMBER(6) NOT NULL,        -- Employee ID
    FIRST_NAME      VARCHAR2(20),              -- Employee's first name
    LAST_NAME       VARCHAR2(25),              -- Employee's last name
    PHONE_NUMBER    VARCHAR2(20),              -- Employee's phone number
    SALARY          NUMBER(8),                 -- Employee's salary
    HIRE_DATE       DATE,                       -- Employee's hire date
    COMMISSION_PCT  NUMBER(5, 2),              -- Commission percentage with (5, 2) format to support decimal values
    DEPARTMENT      VARCHAR2(20),              -- Department where the employee works
    CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EMPLOYEE_ID)  -- Primary key constraint on EMPLOYEE_ID
);

-- 3. Insert sample data into the source table
INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT)
VALUES (1, 'JOHN', 'DOE', '123-456-7890', 5000, TO_DATE('2022-01-01', 'YYYY-MM-DD'), 0.05, 'HR');

INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT)
VALUES (2, 'JANE', 'SMITH', '234-567-8901', 6000, TO_DATE('2021-06-15', 'YYYY-MM-DD'), 0.07, 'IT');

INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT)
VALUES (3, 'ALICE', 'JOHNSON', '345-678-9012', 7000, TO_DATE('2020-03-20', 'YYYY-MM-DD'), 0.04, 'MARKETING');

INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT)
VALUES (4, 'BOB', 'BROWN', '456-789-0123', 5500, TO_DATE('2023-08-10', 'YYYY-MM-DD'), 0.03, 'SALES');

INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT)
VALUES (5, 'CAROL', 'DAVIS', '567-890-1234', 6500, TO_DATE('2022-11-05', 'YYYY-MM-DD'), 0.02, 'FINANCE');

INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT)
VALUES (6, 'DAVID', 'MARTIN', '678-901-2345', 7500, TO_DATE('2021-01-25', 'YYYY-MM-DD'), 0.06, 'HR');

INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT)
VALUES (7, 'EMMA', 'WILSON', '789-012-3456', 8000, TO_DATE('2019-07-12', 'YYYY-MM-DD'), 0.05, 'IT');

-- 4. Verify the data in the source table (Source Table)
SELECT * FROM EMPLOYEE_INFO;
/

-- 1. Check if the target table (TGT_EMPLOYEE_INFO_SCD_T1_PRO) exists and drop it if it does
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TGT_EMPLOYEE_INFO_SCD_T1_PRO PURGE';
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Ignore the error if the table doesn't exist
END;
/

-- 2. Create the target table (Target Table) with modified column size and added columns for commission and total salary
CREATE TABLE TGT_EMPLOYEE_INFO_SCD_T1_PRO (
    EMPLOYEE_ID     NUMBER(6),                -- Employee ID
    FULL_NAME       VARCHAR2(45 BYTE),         -- Employee full name (combined first and last name)
    PHONE_NUMBER    VARCHAR2(20 BYTE),         -- Employee phone number
    SALARY          NUMBER(8),                 -- Employee salary
    HIRE_DATE       DATE,                       -- Employee hire date
    COMMISSION_PCT  NUMBER(5, 2),              -- Commission percentage (same as in source table with decimal support)
    DEPARTMENT      VARCHAR2(20 BYTE),         -- Department where the employee works
    COMMISSION      NUMBER(8, 2),              -- Commission amount for the employee
    TOTAL_SALARY    NUMBER(10, 2)              -- Total salary including commission
);

-- 3. Verify the data in the target table (Target Table)
SELECT * FROM TGT_EMPLOYEE_INFO_SCD_T1_PRO;
/
