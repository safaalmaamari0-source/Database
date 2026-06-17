---------------------08 Stored Procedures & Functions---------------
----- Task 1: Procedure — Add New Employee -----
-- Create the Stored Procedure

CREATE OR REPLACE PROCEDURE SP_ADD_EMPLOYEE (
    p_job_ID  IN VARCHAR2,
    p_fname   IN VARCHAR2,
    p_lname   IN VARCHAR2,
    p_gender  IN VARCHAR2,
    p_age     IN INT,
    p_email   IN VARCHAR2,
    p_pass    IN VARCHAR2
)
AS
    v_count NUMBER;
BEGIN

-- Check if email exists
    SELECT COUNT(*) INTO v_count
    FROM EMPLOYEE
    WHERE emp_email = p_email;

-- IF duplicate THEN print error, ELSE insert
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Email ' || p_email || ' is already in use.');
    ELSE
        INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
        VALUES (TO_CHAR(seq_employee.NEXTVAL), p_job_ID, p_fname, p_lname, p_gender, p_age, p_email, p_pass);

        DBMS_OUTPUT.PUT_LINE('SUCCESS: Employee ' || p_fname || ' ' || p_lname || ' has been added.');
    END IF;

END SP_ADD_EMPLOYEE;
/

SET SERVEROUTPUT ON;
-- TEST 1: New email insert new email
EXEC SP_ADD_EMPLOYEE('1', 'Sara', 'Connor', 'Female', 29, 'sara.connor@company.com', 'hashed_pass_99');

-- TEST 2: insert the same email 
EXEC SP_ADD_EMPLOYEE('1', 'Sara', 'Connor', 'Female', 29, 'sara.connor@company.com', 'hashed_pass_99');

-------Task 2: Function — Calculate Net Salary----

-- Create the Function
CREATE OR REPLACE FUNCTION FN_NET_SALARY (p_emp_ID IN VARCHAR2)
RETURN NUMBER
AS
    v_net_salary NUMBER;
BEGIN

    SELECT amount + bonus INTO v_net_salary
    FROM SALARY_BONUS
    WHERE emp_ID = p_emp_ID;

    RETURN v_net_salary;

END FN_NET_SALARY;
/

-- Use the Function in a SELECT query
SELECT 
    e.emp_ID,
    e.fname || ' ' || e.lname  AS full_name,
    s.amount                    AS salary,
    s.bonus                     AS bonus,
    FN_NET_SALARY(e.emp_ID)     AS net_salary
FROM EMPLOYEE e
JOIN SALARY_BONUS s ON e.emp_ID = s.emp_ID
ORDER BY net_salary DESC;