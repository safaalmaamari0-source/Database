-- 1. Create Job DEPARTMENT Table
CREATE TABLE Job_DEPARTMENT (
    job_ID VARCHAR2(50) PRIMARY KEY,
    name VARCHAR2(100),
    job_dept VARCHAR2(100),
    description CLOB, 
    Salary_range VARCHAR2(100)
);

-- 2. Create SALARY-BONUS Table
CREATE TABLE SALARY_BONUS (
    Salary_ID VARCHAR2(50) PRIMARY KEY,
    amount NUMBER(10, 2), 
    annual VARCHAR2(50),
    bonus NUMBER(10, 2),
    job_ID VARCHAR2(50),
    emp_ID VARCHAR2(50), 
    CONSTRAINT fk_salary_job FOREIGN KEY (job_ID) REFERENCES Job_DEPARTMENT(job_ID)
);

-- 3. Create EMPLOYEE Table
CREATE TABLE EMPLOYEE (
    emp_ID VARCHAR2(50) PRIMARY KEY,
    job_ID VARCHAR2(50),
    fname VARCHAR2(50),
    lname VARCHAR2(50), 
    gender VARCHAR2(10),
    age INT,
    emp_email VARCHAR2(100),
    emp_pass VARCHAR2(255),
    CONSTRAINT fk_emp_job FOREIGN KEY (job_ID) REFERENCES Job_DEPARTMENT(job_ID)
 );
 
 -- 4. Create emp-CONTACT Add Table
CREATE TABLE emp_CONTACT_Add (
    Emp_ID VARCHAR2(50),
    Contact_add VARCHAR2(255),
    PRIMARY KEY (Emp_ID, Contact_add),
    CONSTRAINT fk_contact_emp FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE(emp_ID) ON DELETE CASCADE
);

-- 5. Create PAYROLL Table
CREATE TABLE PAYROLL (
    Payroll_ID VARCHAR2(50) PRIMARY KEY,
    job_ID VARCHAR2(50),
    date_created DATE,
    report CLOB,
    total_amount NUMBER(10, 2), 
    emp_ID VARCHAR2(50), 
    Salary_ID VARCHAR2(50),
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES Job_DEPARTMENT(job_ID),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES EMPLOYEE(emp_ID),
    CONSTRAINT fk_payroll_salary FOREIGN KEY (Salary_ID) REFERENCES SALARY_BONUS(Salary_ID)
);

-- 6. Create QUALIFICATION Table
CREATE TABLE QUALIFICATION (
    qual_ID VARCHAR2(50) PRIMARY KEY,
    Position VARCHAR2(100),
    date_in DATE, 
    emp_ID VARCHAR2(50),
    CONSTRAINT fk_qual_emp FOREIGN KEY (emp_ID) REFERENCES EMPLOYEE(emp_ID) ON DELETE CASCADE
);

-- 7. Create QUAL REQUI Table
CREATE TABLE QUAL_REQUI (
    qual_ID VARCHAR2(50),
    requirement VARCHAR2(255), 
    PRIMARY KEY (qual_ID, requirement),
    CONSTRAINT fk_requi_qual FOREIGN KEY (qual_ID) REFERENCES QUALIFICATION(qual_ID) ON DELETE CASCADE
);

-- 8. Create LEAVE Table
CREATE TABLE LEAVE (
    Leave_ID VARCHAR2(50), 
    emp_ID VARCHAR2(50),
    leave_date DATE, 
    reason CLOB, 
    Payroll_ID VARCHAR2(50),
    PRIMARY KEY (emp_ID, Leave_ID),
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES EMPLOYEE(emp_ID) ON DELETE CASCADE,
    CONSTRAINT fk_leave_payroll FOREIGN KEY (Payroll_ID) REFERENCES PAYROLL(Payroll_ID)
);

SELECT * FROM employee;
SELECT * FROM emp_contact_add;
SELECT * FROM job_department;
SELECT * FROM payroll;
SELECT * FROM qual_requi;
SELECT * FROM qualification;
SELECT * FROM salary_bonus;

--Create the Oracle Sequences 
CREATE SEQUENCE seq_job_dept      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_salary_bonus  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_employee      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_payroll       START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_qualification START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_leave         START WITH 1 INCREMENT BY 1;
 
 
-- 1. Job_DEPARTMENT 
INSERT INTO Job_DEPARTMENT (job_ID, name, job_dept, description, Salary_range)
VALUES (TO_CHAR(seq_job_dept.NEXTVAL), 'Software Engineer', 'IT', 'Designs, develops, and maintains software applications and systems.', '55000-95000');
 
INSERT INTO Job_DEPARTMENT (job_ID, name, job_dept, description, Salary_range)
VALUES (TO_CHAR(seq_job_dept.NEXTVAL), 'HR Manager', 'HR', 'Oversees recruitment, employee relations, and compliance with labour regulations.', '45000-75000');
 
INSERT INTO Job_DEPARTMENT (job_ID, name, job_dept, description, Salary_range)
VALUES (TO_CHAR(seq_job_dept.NEXTVAL), 'Financial Analyst', 'FIN', 'Analyses financial data and prepares strategic budget reports.', '50000-85000');
 
INSERT INTO Job_DEPARTMENT (job_ID, name, job_dept, description, Salary_range)
VALUES (TO_CHAR(seq_job_dept.NEXTVAL), 'Marketing Specialist', 'MKT', 'Plans and executes marketing campaigns and manages brand presence.', '40000-65000');
 
INSERT INTO Job_DEPARTMENT (job_ID, name, job_dept, description, Salary_range)
VALUES (TO_CHAR(seq_job_dept.NEXTVAL), 'Operations Manager', 'OPS', 'Manages daily operational workflows and cross-department logistics.', '60000-100000');
 
-- 2. EMPLOYEE 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '1', 'Alice', 'Thornton', 'Female', 31, 'alice.thornton@company.com', '$2a$12$Hv3xQ7mPdR8nYkLs2Wt4OuBjZcFqA5XeNgVoDwIiKlMpTrUsYb6C1');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '1', 'Brian', 'Okafor', 'Male', 27, 'brian.okafor@company.com', '$2a$12$Jw5yR8nQeS9oZlMt3Xu5PvCkAdGrB6YfOhWpEjNmLqKsTuVbXc7D2');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '2', 'Carmen', 'Delgado', 'Female', 44, 'carmen.delgado@company.com', '$2a$12$Kx6zS9oRfT0pAmNu4Yv6QwDlBeHsC7ZgPiXqFkOnMrLtUvWcYd8E3');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '3', 'David', 'Park', 'Male', 36, 'david.park@company.com', '$2a$12$Ly7aT0pSgU1qBnOv5Zw7RxEmCfItD8AhQjYrGlPoNsLuVwXdZe9F4');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '3', 'Elena', 'Voss', 'Female', 29, 'elena.voss@company.com', '$2a$12$Mz8bU1qThV2rCoWw6Ax8SyFnDgJuE9BiRkZsHmQpOtMvWxYeAf0G5');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '4', 'Femi', 'Adeyemi', 'Male', 33, 'femi.adeyemi@company.com', '$2a$12$Na9cV2rUiW3sDpXx7By9TzGoEhKvF0CjSlAtInRqPuNwXyZfBg1H6');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '4', 'Grace', 'Lim', 'Female', 26, 'grace.lim@company.com', '$2a$12$Ob0dW3sVjX4tEqYy8Cz0UaHpFiLwG1DkTmBuJoSrQvOxYzAgCh2I7');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '5', 'Hank', 'Mueller', 'Male', 50, 'hank.mueller@company.com', '$2a$12$Pc1eX4tWkY5uFrZz9Da1VbIqGjMxH2ElUnCvKpTsRwPyZaBhDi3J8');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '5', 'Ingrid', 'Hansen', 'Female', 41, 'ingrid.hansen@company.com', '$2a$12$Qd2fY5uXlZ6vGsAa0Eb2WcJrHkNyI3FmVoDwLqUtSwQzAbCiEj4K9');
 
INSERT INTO EMPLOYEE (emp_ID, job_ID, fname, lname, gender, age, emp_email, emp_pass)
VALUES (TO_CHAR(seq_employee.NEXTVAL), '1', 'James', 'Nguyen', 'Male', 23, 'james.nguyen@company.com', '$2a$12$Re3gZ6vYmA7wHtBb1Fc3XdKsIlOzJ4GnWpExMrVuTxRaBcDjFk5L0');
 
-- 3. emp_CONTACT_Add 
INSERT INTO emp_CONTACT_Add (Emp_ID, Contact_add) VALUES ('1', '14 Rosewood Lane, Springfield, IL 62701');
INSERT INTO emp_CONTACT_Add (Emp_ID, Contact_add) VALUES ('2', '88 Maple Drive, Austin, TX 73301');
INSERT INTO emp_CONTACT_Add (Emp_ID, Contact_add) VALUES ('3', '5 Birchwood Court, Denver, CO 80201');
INSERT INTO emp_CONTACT_Add (Emp_ID, Contact_add) VALUES ('4', '201 Harbor View Rd, Seattle, WA 98101');
INSERT INTO emp_CONTACT_Add (Emp_ID, Contact_add) VALUES ('5', '77 Lakeshore Blvd, Chicago, IL 60601');
 
-- 4. SALARY_BONUS 
INSERT INTO SALARY_BONUS (Salary_ID, amount, annual, bonus, job_ID, emp_ID)
VALUES (TO_CHAR(seq_salary_bonus.NEXTVAL), 72000, '2026', 5000, '1', '1');
 
INSERT INTO SALARY_BONUS (Salary_ID, amount, annual, bonus, job_ID, emp_ID)
VALUES (TO_CHAR(seq_salary_bonus.NEXTVAL), 58000, '2026', 3500, '1', '2');
 
INSERT INTO SALARY_BONUS (Salary_ID, amount, annual, bonus, job_ID, emp_ID)
VALUES (TO_CHAR(seq_salary_bonus.NEXTVAL), 52000, '2026', 2500, '2', '3');
 
INSERT INTO SALARY_BONUS (Salary_ID, amount, annual, bonus, job_ID, emp_ID)
VALUES (TO_CHAR(seq_salary_bonus.NEXTVAL), 68000, '2026', 4500, '3', '4');
 
INSERT INTO SALARY_BONUS (Salary_ID, amount, annual, bonus, job_ID, emp_ID)
VALUES (TO_CHAR(seq_salary_bonus.NEXTVAL), 80000, '2026', 7000, '5', '8');
 
-- 5. PAYROLL 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '1', TO_DATE('2026-05-31', 'YYYY-MM-DD'), 'May 2026 Payroll Cycle Completed', 7700.00, '1', '1');
 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '1', TO_DATE('2026-05-31', 'YYYY-MM-DD'), 'May 2026 Payroll Cycle Completed', 5800.00, '2', '2');
 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '2', TO_DATE('2026-05-31', 'YYYY-MM-DD'), 'May 2026 Payroll Cycle Completed', 5950.00, '3', '3');
 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '3', TO_DATE('2026-05-31', 'YYYY-MM-DD'), 'May 2026 Payroll Cycle Completed', 7100.00, '4', '4');
 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '5', TO_DATE('2026-05-31', 'YYYY-MM-DD'), 'May 2026 Payroll Cycle Completed', 8700.00, '8', '5');
 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '1', TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'June 2026 Payroll Cycle Completed', 6500.00, '1', '1');
 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '3', TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'June 2026 Payroll Cycle Completed', 5800.00, '5', '4');
 
INSERT INTO PAYROLL (Payroll_ID, job_ID, date_created, report, total_amount, emp_ID, Salary_ID)
VALUES (TO_CHAR(seq_payroll.NEXTVAL), '5', TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'June 2026 Payroll Cycle Completed', 7200.00, '9', '5');
 

-- 6. QUALIFICATION 
INSERT INTO QUALIFICATION (qual_ID, Position, date_in, emp_ID)
VALUES (TO_CHAR(seq_qualification.NEXTVAL), 'Senior Software Engineer', TO_DATE('2019-03-15', 'YYYY-MM-DD'), '1');
 
INSERT INTO QUALIFICATION (qual_ID, Position, date_in, emp_ID)
VALUES (TO_CHAR(seq_qualification.NEXTVAL), 'Junior Software Developer', TO_DATE('2021-08-01', 'YYYY-MM-DD'), '2');
 
INSERT INTO QUALIFICATION (qual_ID, Position, date_in, emp_ID)
VALUES (TO_CHAR(seq_qualification.NEXTVAL), 'HR Business Partner', TO_DATE('2015-06-20', 'YYYY-MM-DD'), '3');
 
INSERT INTO QUALIFICATION (qual_ID, Position, date_in, emp_ID)
VALUES (TO_CHAR(seq_qualification.NEXTVAL), 'Certified Financial Analyst (CFA Level 2)', TO_DATE('2018-11-10', 'YYYY-MM-DD'), '4');
 
INSERT INTO QUALIFICATION (qual_ID, Position, date_in, emp_ID)
VALUES (TO_CHAR(seq_qualification.NEXTVAL), 'Digital Marketing Manager', TO_DATE('2020-02-28', 'YYYY-MM-DD'), '6');
 
-- 7. QUAL_REQUI 

INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('1', 'Bachelor''s degree in Computer Science or related field');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('1', 'Minimum 5 years of software development experience');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('2', 'Bachelor''s degree in Software Engineering');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('2', 'Internship or project experience with modern web frameworks');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('3', 'Bachelor''s degree in Human Resource Management');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('3', 'Minimum 7 years of progressive HR experience');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('4', 'Bachelor''s degree in Finance or Accounting');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('4', 'CFA Level 2 certification or above');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('5', 'Bachelor''s degree in Marketing or Communications');
INSERT INTO QUAL_REQUI (qual_ID, requirement) VALUES ('5', 'Google Analytics and Meta Ads certification');
 
-- 8. LEAVE 
INSERT INTO LEAVE (Leave_ID, emp_ID, leave_date, reason, Payroll_ID)
VALUES (TO_CHAR(seq_leave.NEXTVAL), '1', TO_DATE('2026-05-12', 'YYYY-MM-DD'), 'Medical leave for routine checkup', '1');
 
INSERT INTO LEAVE (Leave_ID, emp_ID, leave_date, reason, Payroll_ID)
VALUES (TO_CHAR(seq_leave.NEXTVAL), '2', TO_DATE('2026-05-20', 'YYYY-MM-DD'), 'Annual vacation leave', '2');
 
INSERT INTO LEAVE (Leave_ID, emp_ID, leave_date, reason, Payroll_ID)
VALUES (TO_CHAR(seq_leave.NEXTVAL), '3', TO_DATE('2026-05-18', 'YYYY-MM-DD'), 'Compassionate leave - bereavement of family member', '3');
 
INSERT INTO LEAVE (Leave_ID, emp_ID, leave_date, reason, Payroll_ID)
VALUES (TO_CHAR(seq_leave.NEXTVAL), '4', TO_DATE('2026-05-05', 'YYYY-MM-DD'), 'Professional development leave - CFA seminar', '4');
 
INSERT INTO LEAVE (Leave_ID, emp_ID, leave_date, reason, Payroll_ID)
VALUES (TO_CHAR(seq_leave.NEXTVAL), '8', TO_DATE('2026-05-25', 'YYYY-MM-DD'), 'Scheduled annual leave - personal travel', '5');
 
COMMIT;

---------------------------------------------------------Task 2: Conditional SELECT Queries----------------------------------
-- (a) Employees aged between 25 and 40, ordered by last name
SELECT emp_ID, fname, lname, age
FROM EMPLOYEE
WHERE age BETWEEN 25 AND 40
ORDER BY lname ASC;

-- (b) Payroll records over 5000 showing employee name and department
SELECT e.fname, e.lname, j.name, j.job_dept, p.total_amount
FROM PAYROLL p
JOIN EMPLOYEE e ON p.emp_ID = e.emp_ID
JOIN Job_DEPARTMENT j ON p.job_ID = j.job_ID
WHERE p.total_amount > 5000;

-- (c) Employees who took leave with reason containing 'sick' (case-insensitive)
SELECT e.emp_ID, e.fname, e.lname, l.reason, l.leave_date
FROM LEAVE l
JOIN EMPLOYEE e ON l.emp_ID = e.emp_ID
WHERE UPPER(l.reason) LIKE '%SICK%';

-- (d) Departments with no employees assigned
SELECT j.job_ID, j.name, j.job_dept
FROM Job_DEPARTMENT j
WHERE NOT EXISTS (
    SELECT 1
    FROM EMPLOYEE e
    WHERE e.job_ID = j.job_ID
);

