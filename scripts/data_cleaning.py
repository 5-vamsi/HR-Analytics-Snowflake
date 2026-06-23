import pandas as pd
import numpy as np
df = pd.read_csv(r"C:\projects\HR-Workforce-Analytics\data\HR.csv")
df.columns = df.columns.str.lower()

# Employee status
df["employee_status"] = np.where(
    df["termdate"].isna(),
    "Active",
    "Terminated"
)

df["attrition_flag"] = np.where(
    df["termdate"].isna(),
    0,
    1
)

# Age groups
df["age_group"] = pd.cut(
    df["age"],
    bins=[0,25,35,45,55,100],
    labels=["18-25","26-35","36-45","46-55","55+"]
)

# Fill missing age groups
df["age_group"] = df["age_group"].astype("object")
df["age_group"] = df["age_group"].fillna("Unknown")

final_cols = [
    "emp_id",
    "gender",
    "race",
    "department",
    "jobtitle",
    "location",
    "location_city",
    "location_state",
    "employee_status",
    "attrition_flag",
    "age",
    "age_group"
]

clean_df = df[final_cols]

# =====================================
# STANDARDIZE COLUMN NAMES
# =====================================

df.columns = (
    df.columns
    .str.strip()
    .str.lower()
)

# =====================================
# REMOVE DUPLICATES
# =====================================

before = len(df)

df = df.drop_duplicates(subset=["emp_id"])

after = len(df)

print(f"Duplicates Removed: {before-after}")

# =====================================
# TRIM WHITESPACES
# =====================================

string_cols = [
    "first_name",
    "last_name",
    "gender",
    "race",
    "department",
    "jobtitle",
    "location",
    "location_city",
    "location_state"
]

for col in string_cols:
    df[col] = df[col].astype(str).str.strip()

# =====================================
# STANDARDIZE TEXT CASE
# =====================================

df["department"] = df["department"].str.title()
df["location_state"] = df["location_state"].str.title()
df["location_city"] = df["location_city"].str.title()
df["location"] = df["location"].str.title()

# =====================================
# DATE CONVERSION
# =====================================

date_cols = [
    "birthdate",
    "hire_date",
    "termdate"
]

for col in date_cols:
    df[col] = pd.to_datetime(
        df[col],
        format="%y-%m-%d",
        errors="coerce"
    )

# =====================================
# EMPLOYEE STATUS
# =====================================

df["employee_status"] = np.where(
    df["termdate"].isna(),
    "Active",
    "Terminated"
)

# =====================================
# ATTRITION FLAG
# =====================================

df["attrition_flag"] = np.where(
    df["termdate"].isna(),
    0,
    1
)

# =====================================
# AGE VALIDATION
# =====================================

df.loc[
    (df["age"] < 18) |
    (df["age"] > 100),
    "age"
] = np.nan

# =====================================
# AGE GROUPS
# =====================================

df["age_group"] = pd.cut(
    df["age"],
    bins=[0,25,35,45,55,100],
    labels=[
        "18-25",
        "26-35",
        "36-45",
        "46-55",
        "55+"
    ]
)

df["age_group"] = (
    df["age_group"]
    .astype("object")
    .fillna("Unknown")
)

# =====================================
# FINAL ANALYTICS DATASET
# =====================================

clean_df = df[
    [
        "emp_id",
        "gender",
        "race",
        "department",
        "jobtitle",
        "location",
        "location_city",
        "location_state",
        "age",
        "age_group",
        "employee_status",
        "attrition_flag"
    ]
]


# VALIDATION


print("\n===== VALIDATION =====")

print("Rows:", len(clean_df))

print(
    "Duplicate EMP_ID:",
    clean_df["emp_id"].duplicated().sum()
)

print(
    "\nNull Values:\n",
    clean_df.isnull().sum()
)

# =====================================
# EXPORT
# =====================================

clean_df.to_csv(
    "data/cleaned_hr.csv",
    index=False
)

print("\ncleaned_hr.csv created successfully")