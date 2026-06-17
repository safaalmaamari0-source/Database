-----------------------------07 Views---------------------------------
----Task 1: Simple Read-Only View -----

-- Create the View VW_EMPLOYEE_SUMMARY 
CREATE VIEW VW_EMPLOYEE_SUMMARY AS
SELECT 
    e.emp_ID,
    e.fname || ' ' || e.lname  AS full_name,
    e.gender,
    e.age,
    j.name                      AS department,
    q.Position                  AS job_title
FROM EMPLOYEE e
JOIN Job_DEPARTMENT j ON e.job_ID = j.job_ID
JOIN QUALIFICATION  q ON e.emp_ID = q.emp_ID;


-- (a) Query the view — female employees over 30
SELECT * FROM VW_EMPLOYEE_SUMMARY
WHERE gender = 'Female' AND age > 30;


-- (b) Try to INSERT through the view
INSERT INTO VW_EMPLOYEE_SUMMARY 
VALUES ('11', 'Test User', 'Male', 25, 'IT', 'Developer');

--Error report -SQL Error: ORA-01779: cannot modify a column which maps to a non key-preserved table--

----Task 2: Payroll Dashboard View----

-- Create the View VW_PAYROLL_DASHBOARD
CREATE VIEW VW_PAYROLL_DASHBOARD AS
SELECT
    p.Payroll_ID,
    e.fname || ' ' || e.lname  AS full_name,
    j.name                      AS department,
    s.amount                    AS salary,
    s.bonus,
    l.reason                    AS leave_reason,
    p.date_created              AS payroll_date,
    p.total_amount
FROM PAYROLL p
JOIN EMPLOYEE     e ON p.emp_ID    = e.emp_ID
JOIN Job_DEPARTMENT j ON p.job_ID  = j.job_ID
JOIN SALARY_BONUS s ON p.Salary_ID = s.Salary_ID
LEFT JOIN LEAVE   l ON p.emp_ID    = l.emp_ID;

-- Query: Top 5 payroll records by total_amount
SELECT * FROM VW_PAYROLL_DASHBOARD
ORDER BY total_amount DESC
FETCH FIRST 5 ROWS ONLY;


