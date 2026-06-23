# HR Workforce & Attrition Analytics Platform

## Project Overview

This project is an end-to-end HR Analytics solution built using Python, Snowflake, SQL, and Power BI. The objective is to analyze workforce distribution, employee attrition, diversity, and geographical trends using a modern data warehousing approach.

The project processes over 22,000 employee records, performs data cleaning and transformation, builds a Snowflake star schema, creates analytical SQL views, and delivers business insights through interactive Power BI dashboards.

---

## Business Problem

Organizations need visibility into workforce composition, employee turnover, and diversity metrics to make informed HR decisions.

This project helps answer questions such as:

- Which departments have the highest attrition rates?
- Which states have the highest employee turnover?
- What is the workforce distribution across departments?
- How diverse is the workforce across gender and race?
- What percentage of employees are active versus terminated?

---

## Architecture

```text
Raw HR Dataset
       │
       ▼
Python Data Cleaning & Transformation
       │
       ▼
Cleaned Dataset
       │
       ▼
Snowflake Data Warehouse
       │
       ├── DIM_EMPLOYEE
       ├── DIM_DEPARTMENT
       ├── DIM_LOCATION
       └── FACT_WORKFORCE
       │
       ▼
Analytics Views
       │
       ▼
Power BI Dashboard
```

---

## Technologies Used

### Programming Language

- Python

### Python Libraries

- Pandas
- NumPy

### Data Warehouse

- Snowflake

### Database Concepts

- Star Schema
- Fact & Dimension Modeling
- Data Warehousing

### Query Language

- SQL

### Visualization

- Power BI

### Development Tools

- VS Code
- Git
- GitHub

---

## Data Cleaning & Transformation

The dataset underwent multiple preprocessing and transformation steps:

- Data profiling and quality assessment
- Null value analysis
- Duplicate record validation
- Employee status creation
- Attrition flag generation
- Age group categorization
- Data standardization and formatting
- Feature engineering for analytical reporting

### Derived Columns

- AGE_GROUP
- EMPLOYEE_STATUS
- ATTRITION_FLAG

---

## Snowflake Data Warehouse Design

### Dimension Tables

#### DIM_EMPLOYEE

Contains employee demographic information:

- Employee ID
- Gender
- Race
- Age
- Age Group

#### DIM_DEPARTMENT

Contains organizational hierarchy information:

- Department
- Job Title

#### DIM_LOCATION

Contains geographical information:

- Location Type
- City
- State

### Fact Table

#### FACT_WORKFORCE

Contains workforce activity metrics:

- Employee Status
- Attrition Flag
- Foreign Keys to Dimensions

---

## Analytical Views

### VW_WORKFORCE_SUMMARY

Provides executive KPIs:

- Total Employees
- Active Employees
- Terminated Employees
- Attrition Rate

### VW_ATTRITION_BY_DEPARTMENT

Department-wise attrition analysis.

### VW_ATTRITION_BY_STATE

State-wise attrition analysis.

### VW_DIVERSITY

Workforce diversity metrics by gender and race.

### VW_REMOTE_VS_HQ

Comparison between Headquarters and Remote workforce.

---

## Dashboard Pages

### 1. Executive Overview

KPIs:

- Total Employees
- Active Employees
- Terminated Employees
- Attrition Rate

Visuals:

- Headquarters vs Remote Workforce
- Attrition Comparison

---

### 2. Department Analytics

Visuals:

- Employee Count by Department
- Attrition Rate by Department

Key Insight:

- Engineering has the largest workforce.
- Certain departments exhibit higher attrition rates than others.

---

### 3. Location Analytics

Visuals:

- Employee Count by State
- Attrition Rate by State

Key Insight:

- Ohio accounts for the majority of employees.
- Attrition varies across states.

---

### 4. Diversity Analytics

Visuals:

- Workforce by Gender
- Workforce by Race
- Gender vs Race Matrix

Key Insight:

- Provides visibility into workforce diversity composition.

---

## Key Insights

- Engineering is the largest department in the organization.
- Workforce distribution is heavily concentrated in Ohio.
- Attrition rates vary significantly across departments.
- Diversity metrics reveal workforce composition across gender and race.
- Headquarters and Remote employees exhibit different attrition patterns.

---

## Project Structure

```text
HR-Analytics-Snowflake/
│
├── data/
│   ├── raw_hr.csv
│   └── cleaned_hr.csv
│
├── notebooks/
│   └── data_cleaning.ipynb
│
├── sql/
│   ├── 01_star_schema.sql
│   ├── 02_views.sql
│   └── 03_validation_queries.sql
│
├── dashboard/
│   └── HR_Analytics.pbix
│
├── screenshots/
│   ├── executive_dashboard.png
│   ├── department_analytics.png
│   ├── location_analytics.png
│   └── diversity_analytics.png
│
└── README.md
```

---

## Future Enhancements

- Automated ETL using Apache Airflow
- Incremental data loading
- Snowflake Tasks and Streams
- Predictive Attrition Modeling
- Workforce Forecasting
- Real-time HR Monitoring

---

## Author

**Vamsikrishna Manne**

Data Analytics | Data Science | Machine Learning | Business Intelligence