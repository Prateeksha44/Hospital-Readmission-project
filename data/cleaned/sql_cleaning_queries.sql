--Standardizing missing values in 'diag_1' column
UPDATE hospital_readmissions
SET diag_1 = NULL
WHERE diag_1 ILIKE 'unknown' OR diag_1 ILIKE 'missing';

--Standardizing missing values in 'diag_2' column
UPDATE hospital_readmissions
SET diag_2 = NULL
WHERE diag_2 ILIKE 'unknown' OR diag_2 ILIKE 'missing';

--Standardizing missing values in 'diag_3' column
UPDATE hospital_readmissions
SET diag_3 = NULL
WHERE diag_3 ILIKE 'unknown' OR diag_3 ILIKE 'missing';

--Standardizing missing values in 'medical_specialty' column
UPDATE hospital_readmissions
SET medical_specialty = NULL
WHERE medical_specialty ILIKE 'missing';

--Calculating the mode for 'glucose_test' column
SELECT glucose_test, COUNT(*) AS frequency
FROM hospital_readmissions
WHERE glucose_test IS NOT NULL
GROUP BY glucose_test
ORDER BY frequency DESC
LIMIT 1;

--Imputing the missing values in 'glucose_test' column with mode
UPDATE hospital_readmissions
SET glucose_test = 'no'
WHERE glucose_test IS NULL;

--Calculating the mode for 'a1ctest' column
SELECT a1ctest, COUNT(*) AS frequency
FROM hospital_readmissions
WHERE a1ctest IS NOT NULL
GROUP BY a1ctest
ORDER BY frequency DESC
LIMIT 1;

--Imputing the missing values in 'a1ctest' column with mode
UPDATE hospital_readmissions
SET a1ctest = 'no'
WHERE a1ctest IS NULL;

--Calculating the mode for 'change' column
SELECT change, COUNT(*) AS frequency
FROM hospital_readmissions
WHERE change IS NOT NULL
GROUP BY change
ORDER BY frequency DESC
LIMIT 1;

--Imputing the missing values in 'change' column with mode
UPDATE hospital_readmissions
SET change = 'no'
WHERE change IS NULL;

--Imputing the missing values in 'time_in_hospital' column with median
UPDATE hospital_readmissions
SET time_in_hospital = sub.median
FROM (
    SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY time_in_hospital) AS median
    FROM hospital_readmissions
    WHERE time_in_hospital IS NOT NULL
) AS sub
WHERE time_in_hospital IS NULL;

--Imputing the missing values in 'n_medications' column with median
UPDATE hospital_readmissions
SET n_medications = sub.median
FROM (
    SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY n_medications) AS median
    FROM hospital_readmissions
    WHERE n_medications IS NOT NULL
) AS sub
WHERE n_medications IS NULL;

----Imputing the missing values in 'n_lab_procedures' column with median
UPDATE hospital_readmissions
SET n_lab_procedures = sub.median
FROM (
    SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY n_lab_procedures) AS median
    FROM hospital_readmissions
    WHERE n_lab_procedures IS NOT NULL
) AS sub
WHERE n_lab_procedures IS NULL;

