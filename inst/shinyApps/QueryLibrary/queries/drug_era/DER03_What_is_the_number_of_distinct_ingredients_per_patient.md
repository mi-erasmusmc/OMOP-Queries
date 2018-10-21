# DER03: What is the number of distinct ingredients per patient?

## Description
Average number of distinct ingredients for all patients.

## Query
```sql
SELECT
        avg(cnt)
from
        (
                select
                        count(distinct r.drug_concept_id) cnt,
                        r.person_id
                FROM
                        drug_era r
                GROUP BY
                        r.person_id
        )
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
| avg |  Average count of distinct ingredient for all patients |

## Sample output record

|  Field |  Value |
| --- | --- |
| avg |  10 |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
