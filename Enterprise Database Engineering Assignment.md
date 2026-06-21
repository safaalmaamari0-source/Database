**Part 1 – Research \& Understanding:**



**---views---**



*1. What is a View?*

a view is a named query that retrieves data from one or more tables. In particular, it acts as a virtual table that enables users to interact with it as if it were a regular table. However, views don’t store any data themselves; instead, they derive their data from one or more underlying tables.



There are three main types of views:

\-simple views: based on a single table, they typically do the job of filtering or rearranging data

\-complex views: combine data from multiple tables and often involve using joins and aggregations

\-materialized views: precomputed views that store the query results on disk with some improvement in performance but require time-to-time refreshing



*2. Why do companies use Views?*

Creating views serves several important purposes in database management.



(1)Simplifying Complex Queries

One of the primary purposes of creating views is to simplify complex queries. This means that views can help encapsulate complex queries to make them more readable and maintainable. We hide the complexities of the underlying tables and joins under views thereby providing a cleaner interface for users to interact with the data. simplify complex queries and enable users who may not have any interest or reason to have in-depth knowledge of the database schema to access the query. This is particularly useful when dealing with large databases.

(2)Providing Data Abstraction

Views also serve the purpose of providing data abstraction. In this case, what we mean by data abstraction is hiding the complexity of the database schema by presenting data in a more friendly format. Doing this might enable users to focus on the information they need without worrying about the underlying table structure. This can make it easier for users to understand and work with the data.

(3) Ensuring Data Consistency

Views can also help ensure data consistency by centralizing data transformations and calculations. When we define these operations in a view, we reduce the risk of errors and inconsistencies that may arise when multiple users perform the same transformations independently. Usually, this is particularly useful when dealing with complex calculations or business logic that need to be applied consistently across the database.



*3. What security benefits do Views provide?*

Another important purpose of creating views is to enhance security. When we decide to restrict access to sensitive data, we can achieve this by using views and presenting only a subset of the available information. By doing this as an administrator, we can control what data can be seen by different user groups. By applying such security measures, we can reduce the risk of data breaches or unauthorized access.

*4. What is the difference between:*

o Table

A table in a database is an organized collection of data stored in rows and columns. It is the fundamental structure for storing persistent data. Each row represents a record, and each column represents an attribute of that record. Tables are designed for direct data storage, updates, and retrieval.

o View

A view is a virtual table based on the result-set of a SQL statement. It doesn’t store data physically but provides a way to look at the underlying tables in a specific way. Views are used to simplify complex queries, provide security by limiting access to certain data, and offer a level of abstraction from the physical table structure.

o Materialized View

A materialized view is similar to a view, but it stores the result-set of the query as a physical table. This means the data is pre-computed and stored, which can significantly improve query performance, especially for complex queries or aggregations. However, the data in a materialized view may not be real-time; it needs to be refreshed to reflect changes in the underlying tables.

|Feature|Table|View|Materialized View|
|-|-|-|-|
|Data Storage|Stores actual data|Stores a query; does not store data directly|Stores the result set of a query as data|
|Data Updates|Direct updates to the data|Updates must be performed on the underlying tables|Requires a refresh to update data|
|Performance|Fast access to data|Can be slower due to query execution|Faster reads since data is pre-computed|
|Real-time Data|Reflects current data|Reflects current data in underlying tables|May not reflect the most current data until refreshed|
|Use Cases|Storing persistent data|Simplifying complex queries, security|Performance optimization for read-heavy workloads|



*5. Give at least three enterprise use cases.*

(1)for example we want to retrieve the names and enrollment dates of students in the Computer Science department. Thus, we can create a view to replace writing a complex join query each time we want to do this.

CREATE VIEW cs\_students AS

SELECT s.name, s.enrollment\_date

FROM Student s

WHERE s.id IN (

&#x20;   SELECT r.student\_id

&#x20;   FROM Registration r

&#x20;   JOIN Course c ON r.course\_id = c.id

&#x20;   WHERE c.department\_id = (

&#x20;       SELECT id FROM Department WHERE name = 'Computer Science'

&#x20;   )

);

&#x20;With this view in place, we can simply query the cs\_students view to access the information in it anytime we need it.

SELECT \* FROM cs\_students;



(2)create a view that shows only the non-sensitive columns of the Student table:

CREATE VIEW student\_info AS

SELECT id, name, enrollment\_date, graduation\_date

FROM Student;

With this view, users with access to the student\_info view won’t be able to see columns like national\_id or birth\_date:

SELECT \* FROM student\_info;



(3)create a view that combines student and course information:

CREATE VIEW student\_courses AS

SELECT s.name AS student\_name, c.name AS course\_name, c.credits

FROM Student s

JOIN Registration r ON s.id = r.student\_id

JOIN Course c ON r.course\_id = c.id;



SELECT \* FROM student\_courses;

As a result, the student\_courses view provides a simplified interface for users to access student and course data without needing to understand the relationships between the tables.



**---Stored Procedures---**



*1.What is a Stored Procedure?*

A stored procedure is a precompiled SQL code that can be saved and reused. If you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.

A stored procedure can also have parameters, so it can act based on the parameter value(s) that is passed.



*2. Why do companies use Procedures?*

Companies use stored procedures mainly for performance, security, and centralization of business logic. Because procedures are precompiled and stored on the server, they execute faster and reduce network traffic (the app sends one call instead of a large SQL statement). They also let DBAs grant execute permissions on a procedure without giving users direct access to underlying tables, which tightens security. And because the logic lives in one place on the server, multiple applications (web app, mobile app, batch jobs) can all call the same procedure and get consistent behavior, instead of each team reimplementing the same business rules in different languages.



*3. What problems do Procedures solve?*

\-Reducing Network Traffic: Stored procedures run faster because they are precompiled, reducing the amount of data sent over the network.

\-Enhancing Security: They limit direct access to tables and protect sensitive data, making it harder for unauthorized users to access or manipulate the database.

\-Improving Performance: Stored procedures can be used to execute multiple SQL statements as one operation, which can improve performance by reducing the number of network round trips.

\-Maintaining Consistency: Stored procedures can enforce consistent business rules across systems, ensuring that all users perform operations in a uniform manner.

\-Preventing SQL Injection: Stored procedures can guard against SQL injection attacks by treating parameter input as literal values and not as executable code.

\-Stored procedures are a powerful tool for database management, providing a way to encapsulate logic and improve the efficiency and security of database operations.



*4. What is the difference between:*

Function and procedure are both elements of programming languages, but they serve different purposes. A function returns a value, and a procedure does not.

Function used mainly for calculations and returns a single value or result; commonly used inside SQL queries.

A procedure executes a set of actions, such as inserting, updating, or deleting data, and does not directly return a value.

Functions are best for computations, and procedures are suited for data manipulation and transaction control.



o Procedure

A procedure is a stored routine that can perform actions, such as inserting, updating, or deleting data. It may also accept input parameters, but it doesn't return a value like a function.

Procedures are used to carry out tasks, such as batch processing, updating records, or performing multiple SQL operations in one go.

A procedure doesn't return a value, but it can affect data or perform a series of steps.



o Function

A function is a stored routine that can take input parameters, perform some processing (such as calculations), and then return a single value (such as a number, string, or date).

Functions are used when you need to compute a value and return it as part of a query.

A function must always return a value.



*5. Give at least three enterprise use cases.*

(1)Monthly payroll run — A RunMonthlyPayroll procedure that loops through all active employees, calculates gross pay, applies tax deductions, inserts payslip records, and updates a payroll history table — run automatically via a scheduled job on the 1st of every month.

(2)ETL / data warehouse staging — A LoadDailySalesSummary procedure that pulls yesterday's transactions from a staging table, aggregates them by region and product, and inserts the results into a reporting table, used as part of a nightly batch job.

(3)Audit logging on sensitive operations — A UpdateEmployeeSalary procedure that not only updates the salary column but also writes a row to an AuditLog table recording who made the change, when, and the old vs new value — ensuring no salary change ever happens without a trace.



**---Triggers---**

*1. What is a Trigger?*

Trigger is a statement that a system executes automatically when there is any modification to the database. In a trigger, we first specify when the trigger is to be executed and then the action to be performed when the trigger executes. Triggers are used to specify certain integrity constraints and referential constraints that cannot be specified using the constraint mechanism of SQL.



*2. Why do companies use Triggers?*

Companies use triggers to enforce business rules and data integrity automatically, without relying on every application or user to remember to follow the rule. They're useful for automatic auditing (logging who changed what and when), maintaining derived/summary data (like keeping a running total in sync), enforcing complex validation that constraints alone can't express, and cascading changes across related tables. Because the logic lives at the database level, it applies no matter how the data is modified — through an app, an ad-hoc query, or a bulk import — closing gaps that application-level validation alone might miss.



*3. What is the difference between:*

The difference between BEFORE and AFTER triggers in a database lies in the timing of their execution relative to the triggering event.

o BEFORE Trigger

BEFORE triggers are executed before any DML operation (INSERT, UPDATE, DELETE) is performed on a table, allowing for validation or modification of data before the change is applied.

o AFTER Trigger

&#x20;AFTER triggers are executed after the DML operation has been performed, making them ideal for logging, auditing, or cascading updates once the data modification is complete.

|Aspect|BEFORE Trigger|AFTER Trigger|
|-|-|-|
|Execution Timing|Executed before the event.|Executed after the event.|
|Access to NEW values|<br />Accessible for modification before data is saved|Available for read-only purposes after the data has been committed.|
|Use Cases|<br />Data modification, validation, or cleansing.|Auditing and logging|
|Can Modify Trigger Data|Yes|No|



*4. What are the risks of excessive Trigger usage?*

Excessive trigger usage in databases can lead to several risks, including:

\-Performance Bottlenecks: Triggers can add significant overhead to database operations, slowing down INSERT, UPDATE, and DELETE operations. This can lead to reduced throughput and increased server load.

\-Complexity and Maintenance Overhead: As the number of triggers increases, the database behavior becomes more complex, making it harder to debug and maintain.

\-Cascading Effects: Poorly designed triggers can cause unintended cascading effects, especially when triggers activate other triggers.

\-Invisibility: Triggers execute invisibly to client applications, making it challenging to troubleshoot issues.

\-Loss of Application Control: When business logic resides in triggers, the application loses control over the logic, which can lead to unpredictable behavior.

To mitigate these risks, it is essential to design and implement triggers with performance in mind, keep them short and simple, and avoid unnecessary complexity.



*5. Give at least three enterprise use cases.*

(1)Auditing: Triggers can be used to automatically log every modification in sensitive tables, such as transaction records in financial institutions. This helps in reducing compliance risks and ensuring traceability of all monetary actions.

(2)Inventory Management: Triggers can notify procurement teams when item levels reach critical thresholds, reducing out-of-stock events by an average of 18% in e-commerce platforms.

(3)Data Integrity: Triggers can ensure referential accuracy across interconnected tables, such as synchronizing patient records across multiple hospital systems.



**---Scheduler Jobs---**

*1. What is a Scheduler Job?*

A scheduler job (also called a scheduled task, cron job, or database job) is a unit of work — typically a script, stored procedure, or sequence of steps — that the database or operating system automatically executes at predefined times or intervals, without any manual trigger or user action. Examples include SQL Server Agent Jobs, Oracle's DBMS\_SCHEDULER, MySQL Events, PostgreSQL's pg\_cron, or OS-level cron jobs/Windows Task Scheduler that call database scripts.



*2. Why do companies use Scheduler Jobs?*

Companies use scheduler jobs to automate repetitive, time-based tasks that would otherwise require someone to manually run a script every day, week, or month — and to ensure these tasks happen reliably, consistently, and at off-peak hours (like 2 AM) when system load is low. This frees staff from routine maintenance work, guarantees tasks aren't forgotten or run late, and centralizes operational tasks like backups, data refreshes, and report generation so they happen the same way every time without human error.



*3. What is the difference between:*

In the context of database management, triggers and scheduler jobs serve different purposes:

Both triggers and scheduler jobs are powerful tools for automating database management and help automate various operations in databases. Triggers help enforce rules and maintain data integrity, while scheduler jobs handle scheduled tasks.

o Trigger

Triggers are special types of stored procedures that automatically execute in response to specific events, such as changes in a table. They are used to enforce business rules, maintain data integrity, and implement complex operations that need to be executed when data is modified.

o Scheduler Job

Scheduler Jobs are automated tasks that run at scheduled times in databases like MySQL or PostgreSQL. They are useful for automating repetitive tasks without human intervention, such as purging old records or updating data.

|Aspect|Trigger|Scheduler Job|
|-|-|-|
|What fires it|A data event (INSERT, UPDATE, DELETE) on a specific table|A point in time or recurring schedule (e.g., daily at 2 AM, every 15 minutes)|
|Frequency|Fires every time the event occurs — could be hundreds of times a day|Runs on a fixed schedule, regardless of how much data changed|
|Scope|Tied to a specific table/view|Independent — can run any script, procedure, or batch process|
|Typical use|Reacting immediately to a single row change|Bulk/batch operations across many rows, or system maintenance|
|Example|"Whenever a row is inserted into Orders, log it"|"Every night at 1 AM, summarize yesterday's orders into a reporting table"|



*4. What processes are commonly automated?*

Common automated processes include nightly database backups and integrity checks, ETL jobs that pull data from operational systems into a data warehouse, refreshing materialized views or summary/reporting tables, sending automated email reports or alerts (e.g., "daily sales summary" to managers), archiving or purging old data (e.g., deleting logs older than 90 days), running batch jobs like payroll calculation or invoice generation, index rebuilding and statistics updates for performance maintenance, and synchronizing data between systems (e.g., syncing a CRM with a billing system every hour).



*5. Give at least three enterprise use cases.*

(1)Nightly data warehouse refresh — A scheduled job that runs every night at 1 AM, calling a stored procedure to pull the previous day's transactions from the operational database, aggregate them, and load them into reporting tables that executives view each morning.

(2)Database maintenance — A scheduled job that runs every Sunday night to rebuild fragmented indexes, update table statistics, and run a full backup, ensuring the database performs well and is recoverable without requiring a DBA to do this manually every week.

(3)Alerting on business thresholds — An hourly job in a banking system that checks for any accounts where the balance has dropped below zero or any transaction exceeds a fraud threshold, and automatically sends an alert email/SMS to the risk management team — catching issues quickly without anyone needing to manually monitor the data.



**Part 2 – Enterprise Decision Making**

*Scenario 1*

1.Identify which object should be used:

View

2\. Explain your reasoning.

based on the scenario the HR department only should see specific columns, A view is exactly designed for this: it acts as a virtual table that exposes only a defined subset of columns (and optionally rows) from the underlying table(s).



*Scenario 2*

1.Identify which object should be used:

Trigger

2\. Explain your reasoning.

based on the scenario "every salary update must automatically be recorded" — this is a reaction to a specific data-changing event (an UPDATE on the salary column), and it must happen every single time that event occurs, regardless of which application, user, or script performs the update. A trigger is built exactly for this: it fires automatically whenever the defined event happens on the table, with no possibility of being skipped or forgotten.



*Scenario 3*

1.Identify which object should be used:

Scheduler Job

2\. Explain your reasoning.

based on the scenario "Management wants a report generated automatically every Friday at 4:00 PM", a scheduler job is purpose-built for exactly this: executing a task (running a report, calling a procedure, exporting data, sending an email) automatically at a fixed point in time on a recurring basis, with zero manual intervention required.



*Scenario 4*

1.Identify which object should be used:

Procedure

2\. Explain your reasoning.

based on the scenario the "Finance department wants one reusable process that annual bonuses", A stored procedure is exactly this: a named, reusable block of logic that encapsulates the bonus calculation rules and can be called whenever needed — by Finance staff, a report, an application, or even a scheduler job later if it needs to run automatically at year-end.



*Scenario 5*

1.Identify which object should be used:

Trigger

2\. Explain your reasoning.

&#x20;"whenever an employee's salary is modified" means the system needs to detect and respond to a specific data-changing event (UPDATE on the Salary column) at the moment it happens, for every single change, regardless of who or what made it. A trigger is the only object that automatically fires in response to that exact event.



*Scenario 6*

1.Identify which object should be used:

View

2\. Explain your reasoning.

based on the scenario "displaying employee information without exposing underlying tables", It presents a curated, virtual "table" that the dashboard can query directly, while the actual base tables (with their full column sets, relationships, and naming conventions) remain hidden from whoever or whatever is consuming the view.



**Part 4 – Reflection**

If applications can perform all business logic themselves, why do enterprise systems still place logic inside the

database?

Application code only runs when that specific application is used. But in enterprise systems, many different apps, tools, and people access the same database — so logic placed only in one app doesn't apply everywhere else. Putting logic in the database makes it apply to everyone, every time.



• Views — If column restrictions (like hiding salary) are coded only in the app, anyone using a different tool to query the database can still see everything. A view enforces the restriction at the database level, so it applies no matter what tool is used.

• Procedures — If business logic (like calculating a bonus) is written separately in the web app, mobile app, and admin tool, each copy can drift apart over time. A procedure is written once in the database, and every app calls the same version.

• Triggers — If "log every salary change" is only in app code, a direct database edit or bulk import skips that code entirely — and nothing gets logged. A trigger fires on the database event itself, so it can't be bypassed.

• Scheduler Job — If a nightly report depends on the app server being online, it can fail if the server is down or restarting. A scheduler job runs inside the database itself, on its own schedule, independent of the app.





