PE09: Number of patients by gender, stratified by year of birth
---

Count the genders (gender_concept_id) across all person records, arrange into groups by year of birth. All possible values for gender concepts stratified by year of birth are summarized.

Sample query:


```sql
SELECT
  gender_concept_id,
  concept_name     AS gender_name,
  year_of_birth,
  COUNT(*) AS num_persons
FROM person p
  JOIN concept c ON p.gender_concept_id = c.concept_id
GROUP BY gender_concept_id, concept_name, year_of_birth
ORDER BY concept_name, year_of_birth
;
```
Input:

None

Output:

|  Field |  Description |
| --- | --- |
|  gender_concept_id |  CDM vocabulary concept identifier |
|  gender_name |  Gender name as defined in CDM vocabulary |
|  year_of_birth |  Stratification by year of birth |
|  num_persons |  Number of patients in the dataset of specific gender / year of birth |

Sample output record:

|  Field |  Value |
| --- | --- |
|  gender_concept_id |  8507 |
|  gender_name |  MALE |
|  year_of_birth |  1950 |
|  num_persons |  169002 |


PE10 :Number of patients by day of the year stratified by day of birth
---

This query is used to count the day of birth (day_of_birth) across all person records. All possible values for day of birth are summarized. Not all databases maintain day of birth. This query is only available from CDM V4 and above.

Sample query:


```sql
SELECT day_of_birth, COUNT(person_ID) AS num_persons
FROM person
GROUP BY day_of_birth
ORDER BY day_of_birth;
```
Input:

None

Output:

|  Field |  Description |
| --- | --- |
| Day_Of_Year | Day of the year 1 through 365 |
| Num_Rows | Number of records |

Sample output record:

| Field |  Value |
| --- | --- |
| Day_Of_Year | 001 |
| Num_Rows | 34462921 |


