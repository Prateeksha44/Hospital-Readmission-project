--Descriptive Statistics for Numeric Columns
--1. Summary statistics for 'time_in_hospital' column
SELECT 
  MIN(time_in_hospital) AS min,
  MAX(time_in_hospital) AS max,
  ROUND(AVG(time_in_hospital),2) AS average,
  PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY time_in_hospital) AS median,
  ROUND(STDDEV(time_in_hospital),2) AS std_dev
FROM hospital_readmissions;

--2. Summary statistics for 'n_lab_procedures' column
SELECT 
  MIN(n_lab_procedures) AS min,
  MAX(n_lab_procedures) AS max,
  ROUND(AVG(n_lab_procedures),2) AS average,
  PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY n_lab_procedures) AS median,
  ROUND(STDDEV(n_lab_procedures),2) AS std_dev
FROM hospital_readmissions;

--3. Summary statistics for 'n_procedures' column
SELECT 
  MIN(n_procedures) AS min,
  MAX(n_procedures) AS max,
  ROUND(AVG(n_procedures),2) AS average,
  PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY n_procedures) AS median,
  ROUND(STDDEV(n_procedures),2) AS std_dev
FROM hospital_readmissions;

--4. Summary statistics for 'n_medications' column
SELECT 
  MIN(n_medications) AS min,
  MAX(n_medications) AS max,
  ROUND(AVG(n_medications),2) AS average,
  PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY n_medications) AS median,
  ROUND(STDDEV(n_medications),2) AS std_dev
FROM hospital_readmissions;

--5. Summary statistics for 'n_outpatient' column
SELECT 
  MIN(n_outpatient) AS min,
  MAX(n_outpatient) AS max,
  ROUND(AVG(n_outpatient),2) AS average,
  PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY n_outpatient) AS median,
  ROUND(STDDEV(n_outpatient),2) AS std_dev
FROM hospital_readmissions;

--6. Summary statistics for 'n_inpatient' column
SELECT 
  MIN(n_inpatient) AS min,
  MAX(n_inpatient) AS max,
  ROUND(AVG(n_inpatient),2) AS average,
  PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY n_inpatient) AS median,
  ROUND(STDDEV(n_inpatient),2) AS std_dev
FROM hospital_readmissions;

--7. Summary statistics for 'n_emergency' column
SELECT 
  MIN(n_emergency) AS min,
  MAX(n_emergency) AS max,
  ROUND(AVG(n_emergency),2) AS average,
  PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY n_emergency) AS median,
  ROUND(STDDEV(n_emergency),2) AS std_dev
FROM hospital_readmissions;

--Distribution of categorical columns
--1. Frequency of values in 'medical_specialty' column
SELECT medical_specialty, COUNT(*) AS count
FROM hospital_readmissions
GROUP BY medical_specialty
ORDER BY count DESC;

--2. Frequency of values in 'diag_1' column
SELECT diag_1, COUNT(*) AS count
FROM hospital_readmissions
GROUP BY diag_1
ORDER BY count DESC;

--3. Frequency of values in 'diag_2' column
SELECT diag_2, COUNT(*) AS count
FROM hospital_readmissions
GROUP BY diag_2
ORDER BY count DESC;

--4. Frequency of values in 'diag_3' column
SELECT diag_3, COUNT(*) AS count
FROM hospital_readmissions
GROUP BY diag_3
ORDER BY count DESC;

--Readmission pattern analysis
-- 1. Readmission Rate Overview
-- What is the percentage of patients who were readmitted vs. not readmitted?
SELECT
  readmitted,
  COUNT(*) AS count,
  ROUND(
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
    2
  ) AS percentage
FROM hospital_readmissions
GROUP BY readmitted;

-- 2. Readmission by Age Group
-- Are older patients more likely to be readmitted?
SELECT 
    age,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
    hospital_readmissions
GROUP BY 
    age
ORDER BY 
    age;

-- 3. Common Primary Diagnoses in Readmitted Patients  
-- Which primary diagnoses are linked with higher readmission rates?
SELECT 
    diag_1,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
    hospital_readmissions
WHERE 
    diag_1 IS NOT NULL
GROUP BY 
    diag_1
ORDER BY 
    readmission_rate_percent DESC;

-- 4. Impact of Secondary Diagnoses (diag_2) on Readmission
-- Which primary diagnoses are linked with higher readmission rates?
SELECT 
    diag_2,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
    hospital_readmissions
WHERE 
    diag_2 IS NOT NULL
GROUP BY 
    diag_2
ORDER BY 
    readmission_rate_percent DESC;

-- 5. Tertiary Diagnosis vs. Readmission
-- Do tertiary diagnoses (diag_3) correlate with higher readmission rates?
SELECT 
    diag_3,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
    hospital_readmissions
WHERE 
    diag_3 IS NOT NULL
GROUP BY 
    diag_3
ORDER BY 
    readmission_rate_percent DESC;

-- 6. Diagnosis Combination Patterns
-- Do certain primary-secondary diagnosis combinations lead to higher readmission risk?
SELECT 
    diag_1,
    diag_2,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
    hospital_readmissions
WHERE 
    diag_1 IS NOT NULL AND diag_2 IS NOT NULL
GROUP BY 
    diag_1, diag_2
ORDER BY 
    readmission_rate_percent DESC
LIMIT 15;

-- 7. Medical Specialty vs. Readmission  
-- What are the readmission rates across different physician specialties, including NULLS?  
SELECT  
    medical_specialty,  
    COUNT(*) AS total_patients,  
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,  
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent  
FROM  
    hospital_readmissions  
GROUP BY  
    medical_specialty  
ORDER BY  
    readmission_rate_percent DESC;

-- 8. Impact of Glucose Test & A1C Test
-- Are patients tested for glucose or A1C more/less likely to be readmitted?
SELECT glucose_test,
       COUNT(*) AS total_patients,
       SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_patients,
       ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM hospital_readmissions
GROUP BY glucose_test
ORDER BY readmission_rate DESC;

SELECT 
    a1ctest,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_patients,
    ROUND(
        100.0 * SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_percent
FROM hospital_readmissions
GROUP BY a1ctest
ORDER BY readmission_rate_percent DESC;

--9. Change in Diabetes Medications vs. Readmission
-- Do changes in diabetes medications correlate with readmission?
SELECT
    change,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_patients,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM hospital_readmissions
GROUP BY change;

-- 10. Binned Time in Hospital vs. Readmission
-- Does the duration of hospital stay influence readmission likelihood?

SELECT 
    CASE 
        WHEN time_in_hospital BETWEEN 1 AND 3 THEN '1-3 days'
        WHEN time_in_hospital BETWEEN 4 AND 6 THEN '4-6 days'
        WHEN time_in_hospital BETWEEN 7 AND 9 THEN '7-9 days'
        ELSE '10-14 days'
    END AS stay_length_bin,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
    hospital_readmissions
GROUP BY 
    stay_length_bin
ORDER BY 
    stay_length_bin;

-- 11. Readmission Rate by Medication Count Ranges
-- Do higher medication counts relate to higher readmission?

SELECT
    CASE 
        WHEN n_medications < 10 THEN '<10'
        WHEN n_medications BETWEEN 10 AND 19 THEN '10-19'
        WHEN n_medications BETWEEN 20 AND 29 THEN '20-29'
        WHEN n_medications BETWEEN 30 AND 39 THEN '30-39'
        ELSE '40+'
    END AS medication_range,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM hospital_readmissions
GROUP BY medication_range
ORDER BY readmission_rate_percent DESC;

-- 12. Binned Procedure Volume vs. Readmission
-- Does procedure volume influence readmission likelihood?

SELECT 
    CASE 
        WHEN n_procedures = 0 THEN '0 procedures'
        WHEN n_procedures BETWEEN 1 AND 2 THEN '1-2 procedures'
        WHEN n_procedures BETWEEN 3 AND 4 THEN '3-4 procedures'
        ELSE '5+ procedures'
    END AS procedure_bin,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
    hospital_readmissions
GROUP BY 
    procedure_bin
ORDER BY 
    procedure_bin;

-- 13. Binned Lab Procedures vs. Readmission Rate
-- How does readmission vary across different ranges of lab procedures?

SELECT
  CASE 
    WHEN n_lab_procedures < 20 THEN '<20'
    WHEN n_lab_procedures BETWEEN 20 AND 40 THEN '20-40'
    WHEN n_lab_procedures BETWEEN 41 AND 60 THEN '41-60'
    WHEN n_lab_procedures BETWEEN 61 AND 80 THEN '61-80'
    ELSE '>80'
  END AS lab_procedure_range,
  COUNT(*) AS total_patients,
  SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
  ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM 
  hospital_readmissions
GROUP BY 
  lab_procedure_range
ORDER BY 
  lab_procedure_range;

--14. Readmission Rate by Inpatient Visit Bins
-- Does the number of inpatient visits influence readmission rates?
SELECT
    CASE 
        WHEN n_inpatient = 0 THEN '0'
        WHEN n_inpatient = 1 THEN '1'
        WHEN n_inpatient BETWEEN 2 AND 3 THEN '2-3'
        ELSE '4+'
    END AS inpatient_visit_range,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM hospital_readmissions
GROUP BY inpatient_visit_range
ORDER BY readmission_rate_percent DESC;

--15. Readmission Rate by Outpatient Visit Bins
-- Does the number of outpatient visits influence readmission rates?
SELECT
    CASE 
        WHEN n_outpatient = 0 THEN '0'
        WHEN n_outpatient = 1 THEN '1'
        WHEN n_outpatient BETWEEN 2 AND 4 THEN '2-4'
        ELSE '5+'
    END AS outpatient_visit_range,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM hospital_readmissions
GROUP BY outpatient_visit_range
ORDER BY readmission_rate_percent DESC;

--16. Readmission Rate by Emergency Visit Bins
-- Does the number of emergency visits influence readmission rates?
SELECT
    CASE 
        WHEN n_emergency = 0 THEN '0'
        WHEN n_emergency = 1 THEN '1'
        WHEN n_emergency BETWEEN 2 AND 3 THEN '2-3'
        ELSE '4+'
    END AS emergency_visit_range,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_percent
FROM hospital_readmissions
GROUP BY emergency_visit_range
ORDER BY readmission_rate_percent DESC;

	