----------------------10 Oracle Scheduler Jobs-------------------
-------------Task 1: Simple One-Time Scheduler Job------------

-- Create the Scheduler Job
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name   => 'JOB_GREET_EMPLOYEES',
        job_type   => 'PLSQL_BLOCK',
        job_action => 'BEGIN
                        DBMS_OUTPUT.PUT_LINE(''Payroll System Initialized'');
                        INSERT INTO EMPLOYEE_LOG (log_id, emp_id, action, log_timestamp)
                        VALUES (seq_emp_log.NEXTVAL, NULL, ''SYSTEM INIT'', SYSDATE);
                        COMMIT;
                       END;',
        start_date => SYSTIMESTAMP + INTERVAL '2' MINUTE,
        enabled    => TRUE
    );
END;
/

SELECT log_id, emp_id, action, log_timestamp
FROM EMPLOYEE_LOG
WHERE action = 'SYSTEM INIT';

SELECT job_name, status, log_date
FROM USER_SCHEDULER_JOB_LOG
WHERE job_name = 'JOB_GREET_EMPLOYEES';

SELECT * FROM EMPLOYEE_LOG
WHERE action = 'SYSTEM INIT';

---------Task 2: Recurring Job — Daily Leave Report---------
---Create a recurring DBMS_SCHEDULER job
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name        => 'JOB_DAILY_LEAVE_REPORT',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN
                                INSERT INTO EMPLOYEE_LOG (log_id, emp_id, action, log_timestamp)
                                SELECT seq_emp_log.NEXTVAL, NULL,
                                       ''DAILY LEAVE REPORT: '' || COUNT(*) || '' leave(s) today'',
                                       SYSDATE
                                FROM LEAVE
                                WHERE leave_date = TRUNC(SYSDATE);
                                COMMIT;
                            END;',
        start_date      => TRUNC(SYSDATE + 1) + 7/24,
        repeat_interval => 'FREQ=DAILY; BYHOUR=7; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE
    );
END;
/

---Show the job definition
SELECT job_name, enabled, state, repeat_interval, next_run_date
FROM USER_SCHEDULER_JOBS
WHERE job_name = 'JOB_DAILY_LEAVE_REPORT';