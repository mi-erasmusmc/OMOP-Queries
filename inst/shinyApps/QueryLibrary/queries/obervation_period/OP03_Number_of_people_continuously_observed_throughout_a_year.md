# OP03:Number of people continuously observed throughout a year.

## Description
Count number of people continuously observed throughout a specified year.

## Query
```sql
SELECT COUNT(DISTINCT person_ID) AS NUM_persons
FROM observation_period
WHERE observation_period_start_date <= '01-jan-2011'
AND observation_period_end_date >= '31-dec-2011';
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
| num_persons |  Number of patients whose observation period within range of days |

## Sample output record

|  Field |  Value |
| --- | --- |
| num_persons |  32611748 |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
