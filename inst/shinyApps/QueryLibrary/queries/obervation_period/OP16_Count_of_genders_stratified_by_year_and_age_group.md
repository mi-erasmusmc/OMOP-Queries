# OP16: Count of genders, stratified by year and age group

## Description
This query is used to count the genders (gender_concept_id) across all observation period records stratified by year and age group. The age groups are calculated as 10 year age bands from the age of a person at the observation period start date. All possible value combinations are summarized.

## Query
```sql
SELECT
  observation_year,
  age_group,
  gender,
  count(*) AS num_people
FROM (
  SELECT DISTINCT
    person_id ,
    EXTRACT( YEAR from observation_period_start_date ) AS observation_year
  FROM observation_period
)
JOIN (
  SELECT
    person_id,
    gender ,
    CAST(FLOOR( age / 10 ) * 10 AS VARCHAR)||' to '||CAST(( FLOOR( age / 10 ) * 10 ) + 9 AS VARCHAR) AS age_group
  FROM (
    SELECT
      person_id,
      NVL( concept_name, 'MISSING' ) AS gender,
      year_of_birth ,
      extract( YEAR FROM first_observation_date ) - year_of_birth AS age
    FROM (
      SELECT
        person_id,
        gender_concept_id,
        year_of_birth ,
        min( observation_period_start_date ) AS first_observation_date
      FROM
        observation_period
      JOIN person USING( person_id )
      GROUP BY
        person_id,
        gender_concept_id,
        year_of_birth
    )
    LEFT OUTER JOIN concept ON concept_id = gender_concept_id
    WHERE year_of_birth IS NOT NULL
  )
  WHERE age >= 0
) USING( person_id )
GROUP BY
  observation_year,
  age_group,
  gender
ORDER BY
  observation_year,
  age_group,
  gender;
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
| observation_year | Year of observation |
| age_group | Group of person by age |
| gender | Gender concept name |
| num_people | Number of people within year of observation, age group and gender |



## Sample output record

|  Field |  Description |
| --- | --- |
| observation_year |  2003 |
| age_group |  10 to 19 |
| gender |  MALE |
| num_people |  12060 |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
