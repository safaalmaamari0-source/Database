---04 Aggregation Functions---

----Task 1: Basic Aggregation----
-- (a) Total number of employees in each department
SELECT j.name, j.job_dept, COUNT(e.emp_ID) AS total_employees
FROM Job_DEPARTMENT j
LEFT JOIN EMPLOYEE e ON j.job_ID = e.job_ID
GROUP BY j.name, j.job_dept;

-- (b) Minimum, maximum, and average salary across all salary records
SELECT 
    MIN(amount)  AS min_salary,
    MAX(amount)  AS max_salary,
    ROUND(AVG(amount), 2) AS avg_salary
FROM SALARY_BONUS;

-- (c) Total bonus paid out across the entire company
SELECT SUM(bonus) AS total_bonus_paid
FROM SALARY_BONUS;


-----Task 2: GROUP BY with HAVING----
-- (a) Departments where average employee age exceeds 30
SELECT j.name, j.job_dept, ROUND(AVG(e.age), 1) AS avg_age
FROM EMPLOYEE e
JOIN Job_DEPARTMENT j ON e.job_ID = j.job_ID
GROUP BY j.name, j.job_dept
HAVING AVG(e.age) > 30;

-- (b) Job titles (qualification positions) shared by more than 2 employees
SELECT Position, COUNT(emp_ID) AS total_employees
FROM QUALIFICATION
GROUP BY Position
HAVING COUNT(emp_ID) > 2;

-- (c) Months where total payroll amount exceeds 20,000
SELECT 
    TO_CHAR(date_created, 'YYYY-MM')  AS payroll_month,
    SUM(total_amount)                  AS monthly_total
FROM PAYROLL
GROUP BY TO_CHAR(date_created, 'YYYY-MM')
HAVING SUM(total_amount) > 20000
ORDER BY payroll_month;
