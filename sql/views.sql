

CREATE OR REPLACE VIEW VW_WORKFORCE_SUMMARY AS
SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN employee_status = 'Active' THEN 1 ELSE 0 END) AS active_employees,
    SUM(CASE WHEN employee_status = 'Terminated' THEN 1 ELSE 0 END) AS terminated_employees,
    ROUND(
        100.0 * SUM(attrition_flag) / COUNT(*),
        2
    ) AS attrition_rate
FROM FACT_WORKFORCE;
SELECT * FROM VW_WORKFORCE_SUMMARY;


CREATE OR REPLACE VIEW VW_ATTRITION_BY_DEPARTMENT AS
SELECT
    d.department,

    COUNT(*) AS employee_count,

    SUM(f.attrition_flag) AS attrition_count,

    ROUND(
        100.0 * SUM(f.attrition_flag) / COUNT(*),
        2
    ) AS attrition_rate

FROM FACT_WORKFORCE f

JOIN DIM_DEPARTMENT d
ON f.department_key = d.department_key

GROUP BY d.department;

SELECT *
FROM VW_ATTRITION_BY_DEPARTMENT
ORDER BY attrition_rate DESC;

CREATE OR REPLACE VIEW VW_ATTRITION_BY_STATE AS
SELECT
    l.location_state,

    COUNT(*) AS employee_count,

    SUM(f.attrition_flag) AS attrition_count,

    ROUND(
        100.0 * SUM(f.attrition_flag) / COUNT(*),
        2
    ) AS attrition_rate

FROM FACT_WORKFORCE f

JOIN DIM_LOCATION l
ON f.location_key = l.location_key

GROUP BY l.location_state;

SELECT *
FROM VW_ATTRITION_BY_STATE
ORDER BY attrition_rate DESC;

CREATE OR REPLACE VIEW VW_DIVERSITY AS
SELECT
    e.gender,
    e.race,
    COUNT(*) AS employee_count
FROM FACT_WORKFORCE f

JOIN DIM_EMPLOYEE e
ON f.employee_key = e.employee_key

GROUP BY
    e.gender,
    e.race;

    SELECT *
FROM VW_DIVERSITY order by employee_count;

SELECT CURRENT_ACCOUNT();

SELECT *
FROM VW_ATTRITION_BY_DEPARTMENT;

CREATE OR REPLACE VIEW VW_REMOTE_VS_HQ AS
SELECT
    l.location,

    COUNT(*) AS employee_count,

    SUM(f.attrition_flag) AS attrition_count,

    ROUND(
        100.0 * SUM(f.attrition_flag) / COUNT(*),
        2
    ) AS attrition_rate

FROM FACT_WORKFORCE f

JOIN DIM_LOCATION l
ON f.location_key = l.location_key

GROUP BY l.location;

SELECT *
FROM VW_REMOTE_VS_HQ;