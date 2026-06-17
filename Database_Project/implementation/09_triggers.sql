--------------------09 Triggers---------------------
----Task 1: BEFORE INSERT — Auto-Assign emp_ID----

--Create a BEFORE INSERT trigger 
CREATE OR REPLACE TRIGGER TRG_EMP_ID
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN

    IF :NEW.emp_ID IS NULL THEN
        :NEW.emp_ID := TO_CHAR(seq_employee.NEXTVAL);
    END IF;

END TRG_EMP_ID;
/

--Test: INSERT an employee without specifying emp_ID--
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (NULL, '1', 'Tom', 'Hardy', 'Male', 35, 'tom.hardy@company.com', 'hashed_pass_tom');

COMMIT;

---verify it was auto-assigned--
SELECT emp_ID, fname, lname, emp_email
FROM EMPLOYEE
WHERE emp_email = 'tom.hardy@company.com';

-------Task 2: AFTER INSERT — Welcome Log----
--Create a table EMPLOYEE_LOG--
CREATE TABLE EMPLOYEE_LOG (
    log_id        NUMBER PRIMARY KEY,
    emp_id        VARCHAR2(50),
    action        VARCHAR2(50),
    log_timestamp DATE
);

CREATE SEQUENCE seq_emp_log START WITH 1 INCREMENT BY 1;

---Create an AFTER INSERT trigger named TRG_EMP_WELCOME_LOG----
CREATE OR REPLACE TRIGGER TRG_EMP_WELCOME_LOG
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN

    INSERT INTO EMPLOYEE_LOG (log_id, emp_id, action, log_timestamp)
    VALUES (seq_emp_log.NEXTVAL, :NEW.emp_ID, 'NEW HIRE', SYSDATE);

END TRG_EMP_WELCOME_LOG;
/

--Test by inserting 1 employee
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (NULL, '1', 'Anna', 'Smith', 'Female', 28, 'anna.smith@company.com', 'hashed_pass_anna');
--Test by inserting 2nd employee
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (NULL, '2', 'Mark', 'Jones', 'Male', 32, 'mark.jones@company.com', 'hashed_pass_mark');

COMMIT;

-- To verify 
SELECT * FROM EMPLOYEE_LOG;