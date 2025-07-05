# 🏥 Hospital Readmission Risk: A Data-Driven Analysis

This repository contains datasets for a hospital readmission analysis project. The project involves initial data cleaning using Excel, followed by advanced cleaning and analysis in PostgreSQL, and concludes with visualization of insights using Power BI. Some synthetic data quality challenges were added to the initial raw dataset to mimic real-world data issues commonly found in messy healthcare records.

## 📁 Dataset Overview

The following datasets are organized under the `data/` directory of this repository:

### 1. `data/raw/`
- `hospital_readmissions_raw.csv`: Original unprocessed dataset.

### 2. `data/data_challenges_introduced/`
- `hospital_readmissions_data_challenges.csv`: A version of the dataset with data quality issues intentionally introduced.
- `synthetic_data_quality_challenges.csv`: A list of synthetic data challenges that were introduced into the raw dataset to simulate realistic data issues and inconsistencies.

### 3. `data/cleaned/`
- `hospital_readmissions_cleaned.csv`: Dataset cleaned using Excel (fixing inconsistent casing, leading spaces, spelling errors and exploring missing data patterns).
- `hospital_readmissions_cleaned_sql.csv`: Dataset exported after performing further cleaning using SQL in PostgreSQL (standardizing missing values and imputing missing values).
  
### 5. `sql_queries/`
- `sql_data_cleaning_queries.sql`: A list of SQL queries used to clean the dataset in PostgreSQL, including comments describing each step.
- `eda_sql_queries.sql`:  SQL queries used for descriptive statistics, frequency distributions and analyzing readmission patterns.

### 5. `Hospital_readmissions_dashboard/`
- **Hospital_Readmissions_Report.pbix**: Final Power BI dashboard file used to visualize key patterns, trends, and insights.


---

## 📚 More Information

For detailed documentation, methodology, and ongoing project notes, please refer to the Notion page below:

👉 [View Full Project Details on Notion](https://www.notion.so/Reducing-Hospital-Readmission-Risks-Using-Data-Driven-Insights-1ea1279cd9ac804e8827e7a3288d9d27?pvs=4)

---

## 🔗 Dataset Source

The original raw dataset used in this project can be found on Kaggle:

📥 [Hospital Readmissions Dataset on Kaggle](https://www.kaggle.com/datasets/dubradave/hospital-readmissions)

*Note: This repository contains a modified version of the dataset, including synthetic challenges introduced for analysis purposes.*
