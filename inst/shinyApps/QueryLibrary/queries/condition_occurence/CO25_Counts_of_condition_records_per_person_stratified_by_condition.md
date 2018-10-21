# CO25: Counts of condition records per person, stratified by condition.

## Description
Count number of condition per person stratified by condition.

## Query
```sql
SELECT condition_concept_id, num_of_occurrences, count(*) num_of_patients
FROM (
SELECT condition_concept_id, person_id, count(*) num_of_occurrences
FROM condition_occurrence co
WHERE co.condition_concept_id = 200219
GROUP BY person_id, condition_concept_id)
GROUP BY condition_concept_id, num_of_occurrences;
```

## Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| condition_concept_id | 200219 | Yes | Condition concept identifier for 'Abdominal pain' |

## Output

|  Field |  Description |
| --- | --- |
| condition_concept_id | Condition concept identifier |
| num_occurrences | Number of condition occurrences |
| num_of_patients | Number of patients with num_occurrences |

## Sample output record

|  Field |  Description |
| --- | --- |
| condition_concept_id |  200219 |
| num_occurrences |  10 |
| num_of_patients |  3681 |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
