# CE10: Counts of persons with conditions

## Description
This query is used to count the persons with any number of eras of a certain condition (condition_concept_id). The input to the query is a value (or a comma-separated list of values) of a condition_concept_id. If the input is omitted, all possible values are summarized.
## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| list of condition_concept_id | 320128, 432867, 254761, 257011, 257007 | No |   |

## Query
The following is a sample run of the query. The input parameters are highlighted in  blue

```sql
SELECT condition_concept_id, concept_name, count( distinct person_id ) num_people
  FROM condition_era
  JOIN concept ON concept_id = condition_concept_id
 WHERE condition_concept_id 
    IN /* top five condition concepts by number of people */
       ( 320128, 432867, 254761, 257011, 257007 )
 GROUP BY condition_concept_id, concept_name
 ORDER BY num_people DESC;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
| concept_name | An unambiguous, meaningful and descriptive name for the concept |
| condition_concept_id | A foreign key that refers to a standard condition concept identifier in the vocabulary. |
| num_people |   |

## Sample output record

|  Field |  Description |
| --- | --- |
| concept_name |   |
| condition_concept_id |   |
| num_people |   |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
