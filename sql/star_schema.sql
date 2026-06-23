CREATE DATABASE HR_ANALYTICS;
USE DATABASE HR_ANALYTICS;

CREATE SCHEMA WORKFORCE;
USE SCHEMA WORKFORCE;
CREATE WAREHOUSE HR_WH
WITH WAREHOUSE_SIZE='XSMALL'
AUTO_SUSPEND=60
AUTO_RESUME=TRUE;
USE WAREHOUSE HR_WH;
SELECT CURRENT_DATABASE(),
       CURRENT_SCHEMA(),
       CURRENT_WAREHOUSE();
CREATE OR REPLACE STAGE HR_STAGE;
SHOW STAGES;


SHOW SCHEMAS IN DATABASE HR_ANALYTICS;
SHOW STAGES;

SELECT COUNT(*)
FROM HR_ANALYTICS.WORKFORCE."cleaned data";
SHOW TABLES IN SCHEMA HR_ANALYTICS.WORKFORCE;
DESC TABLE HR_ANALYTICS.WORKFORCE."cleaned data";


CREATE OR REPLACE TABLE DIM_EMPLOYEE AS
SELECT
    ROW_NUMBER() OVER (ORDER BY emp_id) AS employee_key,
    emp_id,
    gender,
    race,
    age,
    age_group
FROM "cleaned data";
SELECT COUNT(*) FROM DIM_EMPLOYEE;

CREATE OR REPLACE TABLE DIM_DEPARTMENT AS
SELECT
    ROW_NUMBER() OVER (
        ORDER BY department, jobtitle
    ) AS department_key,
    department,
    jobtitle
FROM (
    SELECT DISTINCT
        department,
        jobtitle
    FROM "cleaned data"
);

SELECT COUNT(*)
FROM DIM_DEPARTMENT;

CREATE OR REPLACE TABLE DIM_LOCATION AS
SELECT
    ROW_NUMBER() OVER (
        ORDER BY location,
                 location_city,
                 location_state
    ) AS location_key,
    location,
    location_city,
    location_state
FROM (
    SELECT DISTINCT
        location,
        location_city,
        location_state
    FROM "cleaned data"
);

select count(*) from DIM_LOCATION;
CREATE OR REPLACE TABLE FACT_WORKFORCE AS
SELECT
    e.employee_key,
    d.department_key,
    l.location_key,

    c.employee_status,
    c.attrition_flag

FROM "cleaned data" c

JOIN DIM_EMPLOYEE e
ON c.emp_id = e.emp_id

JOIN DIM_DEPARTMENT d
ON c.department = d.department
AND c.jobtitle = d.jobtitle

JOIN DIM_LOCATION l
ON c.location = l.location
AND c.location_city = l.location_city
AND c.location_state = l.location_state;

SELECT COUNT(*)
FROM FACT_WORKFORCE;
