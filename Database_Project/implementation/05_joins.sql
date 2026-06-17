--------05 Joins---------
--------------Task 1: INNER JOIN — Employee Full Profile---
-- Complete employee profile using INNER JOINs
SELECT 
    e.emp_ID,
    e.fname || ' ' || e.lname          AS full_name,
    j.name                              AS department,
    q.Position                          AS job_title,
    s.amount                            AS salary,
    MAX(l.leave_date)                   AS latest_leave_date
FROM EMPLOYEE e
JOIN Job_DEPARTMENT j  ON e.job_ID    = j.job_ID
JOIN QUALIFICATION  q  ON e.emp_ID    = q.emp_ID
JOIN SALARY_BONUS   s  ON e.emp_ID    = s.emp_ID
JOIN PAYROLL        p  ON e.emp_ID    = p.emp_ID
JOIN LEAVE          l  ON e.emp_ID    = l.emp_ID
GROUP BY
    e.emp_ID,
    e.fname || ' ' || e.lname,
    j.name,
    q.Position,
    s.amount;

-------------Task 2: LEFT OUTER JOIN — Missing Records-----------
-- (a) Employees who have never taken any leave  
SELECT e.emp_ID, e.fname, e.lname
FROM EMPLOYEE e
LEFT JOIN LEAVE l ON e.emp_ID = l.emp_ID
WHERE l.emp_ID IS NULL;

-- (b) Departments that have no salary/bonus records
SELECT j.job_ID, j.name, j.job_dept
FROM Job_DEPARTMENT j
LEFT JOIN SALARY_BONUS s ON j.job_ID = s.job_ID
WHERE s.job_ID IS NULL;



