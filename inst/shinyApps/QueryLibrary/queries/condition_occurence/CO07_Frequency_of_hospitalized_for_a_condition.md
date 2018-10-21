# CO07 :Frequency of hospitalized for a condition

## Description
Returns the distribution of number of times a person has been hospitalized where a certain condition was reported.

## Query
```sql
SELECT
  number_of_hospitlizations,
  count(*) AS persons_freq
FROM (
  SELECT
    person_id,
    COUNT(*) AS number_of_hospitlizations
  FROM (
    SELECT distinct
      condition_era_id,
      era.person_id
    FROM (
      SELECT
        condition_start_date,
        condition_end_date,
        from_cond.person_id
      FROM (
        SELECT
          visit_occurrence_id,
          condition_start_date,
          condition_end_date,
          person_id
        FROM condition_occurrence
        WHERE
          condition_concept_id=31967 AND
          visit_occurrence_id IS NOT NULL
      ) AS FROM_cond
      JOIN visit_occurrence AS FROM_visit
        ON FROM_cond.visit_occurrence_id=FROM_visit.visit_occurrence_id
      JOIN care_site cs on from_visit.care_site_id=cs.care_site_id
         where place_of_service_concept_id=8717
    ) AS occurr,
    (
      SELECT
        condition_era_id,
        person_id,
        condition_era_start_date,
        condition_era_end_date
      FROM condition_era
      WHERE condition_concept_id=31967
    ) AS era
    WHERE
      era.person_id=occurr.person_id AND
      era.condition_era_start_date <= occurr.condition_end_date AND
      (era.condition_era_end_date IS NULL OR era.condition_era_end_date >= occurr.condition_start_date)
  )
  GROUP BY person_id
  ORDER BY number_of_hospitlizations desc
)
GROUP BY number_of_hospitlizations
ORDER BY persons_freq desc
;
```

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| condition_concept_id | 31967 | Yes | Condition concept identifier for 'Nausea' |

## Output

|  Field |  Description |
| --- | --- |
| number_of_hospitlizations | Number of times a person was reported to be hospitalized with a certain condition. |
| persons_freq | Number of persons which were reported to have a certain number of hospilizations with a certain condition. |

## Sample output record

| Field |  Description |
| --- | --- |
| number_of_hospitlizations | 2 |
| persons_freq | 177 |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
