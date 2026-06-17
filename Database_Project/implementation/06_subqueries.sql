-----06 Subqueries-----
-------------------Task 1: Single-Row Subquery-------------
-- (a) Employees earning above the company average salary
SELECT e.emp_ID, e.fname, e.lname, s.amount
FROM EMPLOYEE e
JOIN SALARY_BONUS s ON e.emp_ID = s.emp_ID
WHERE s.amount > (SELECT AVG(amount) FROM SALARY_BONUS);

-- (b) Department with the highest total payroll amount
SELECT j.name, j.job_dept, SUM(p.total_amount) AS total_payroll
FROM PAYROLL p
JOIN Job_DEPARTMENT j ON p.job_ID = j.job_ID
GROUP BY j.name, j.job_dept
HAVING SUM(p.total_amount) = (SELECT MAX(SUM(total_amount))  FROM PAYROLL GROUP BY job_ID);

------------------Task 2: Multi-Row Subquery with IN / ANY / ALL------

-- (a) Employees who work in departments that have at least one bonus > 500  
SELECT e.emp_ID, e.fname, e.lname
FROM EMPLOYEE e
WHERE e.job_ID IN (
    SELECT job_ID FROM SALARY_BONUS WHERE bonus > 500
);

-- (b) Employees earning more than ALL salaries in the OPS department  
SELECT e.emp_ID, e.fname, e.lname, s.amount
FROM EMPLOYEE e
JOIN SALARY_BONUS s ON e.emp_ID = s.emp_ID
WHERE s.amount > ALL (
    SELECT amount FROM SALARY_BONUS
    WHERE job_ID = (SELECT job_ID FROM Job_DEPARTMENT WHERE job_dept = 'OPS')
);

-- (c) Employees earning more than ANY salary in the HR department 
SELECT e.emp_ID, e.fname, e.lname, s.amount
FROM EMPLOYEE e
JOIN SALARY_BONUS s ON e.emp_ID = s.emp_ID
WHERE s.amount > ANY (
    SELECT amount FROM SALARY_BONUS
    WHERE job_ID = (SELECT job_ID FROM Job_DEPARTMENT WHERE job_dept = 'HR')
);
