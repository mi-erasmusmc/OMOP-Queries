# PP01: Continuous years with patient counts

## Description
List number of patients who have continuous payer plan of at least one year

## Query
```sql
SELECT floor((p.payer_plan_period_end_date - p.payer_plan_period_start_date)/365) AS year_int, count(1) AS num_patients
FROM payer_plan_period p
GROUP BY floor((p.payer_plan_period_end_date - p.payer_plan_period_start_date)/365)
ORDER BY 1;
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
| year_int | Years between payer plan end date and start date |
| num_patients | Number of patients |

## Sample output record

| Field |  Description |
| --- | --- |
| year_int |  1 |
| num_patients |  42458099 |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
