--------------02 Normalization------------------

-----Task 1: First Normal Form (1NF) Analysis-----
--(a) Identify every violation of 1NF in this table and explain each one clearly.
--Violation 1: phone_numbers And job_titles are Multi-Valued Attributes.
--1NF requires every cell to hold one single value only.
--Violation 2: full_name is a Composite Attribute.
--1NF requires atomic values — should be split into fname and lname.
--Violation 3: No Primary Key.
--1NF requires every table to have a primary key that uniquely identifies each row.

--(b) Rewrite the table in 1NF. Show the resulting table(s) with at least 3 rows of sample data.
--EMP_RAW (emp_id, fname, lname, dept_name, dept_location, salary)
--EMP_PHONES (emp_id, phone_number)
--EMP_JOBS (emp_id, job_title)

----Task 2: Second Normal Form (2NF) Analysis----

--(a) Identify all partial dependencies — attributes that depend on only part of the composite key.
--Partial Dependency 1 — emp_name depends only on emp_ID.
--Partial Dependency 2 — job_title depends only on job_ID.
--Partial Dependency 3 — salary_range depends only on job_ID.

--(b) Decompose the table into 2NF relations. Write the schema for each resulting table.
--Table EMPLOYEE (emp_ID, emp_name)
--Table JOB (job_ID, job_title, salary_range)
--Table PAYROLL_RAW (emp_ID, job_ID, pay_date, total_amount)
