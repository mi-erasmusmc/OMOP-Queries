# OP15: Counts of age, stratified by gender

## Description
This query is used to count the age across all observation records stratified by gender (gender_concept_id). The age value is defined by the earliest observation date. Age is summarized for all existing gender_concept_id values.

## Query
```sql
SELECT        age,
                gender,
                count(*) AS num_people
FROM
        (
        SELECT        person_id,
                        NVL( concept_name, 'MISSING' ) AS gender,
                        extract( YEAR FROM first_observation_date ) - year_of_birth AS age
        FROM
                (
                SELECT        person_id,
                                min( observation_period_start_date ) AS first_observation_date
                FROM
                        observation_period
                GROUP BY person_id
                )
                        JOIN
                                person USING( person_id )
                        LEFT OUTER JOIN
                                concept
                                        ON        concept_id = gender_concept_id
        WHERE
                extract( YEAR FROM first_observation_date ) - year_of_birth >= 0
        )
GROUP BY        age,
                        gender
ORDER BY        age,
                        gender
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
| age | Age across within observation |
| gender | Gender concept name stratification |
| num_people | Number of person within group |

## Sample output record

| Field |  Description |
| --- | --- |
| age |  1 |
| gender |  MALE |
| num_people |  22501 |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
