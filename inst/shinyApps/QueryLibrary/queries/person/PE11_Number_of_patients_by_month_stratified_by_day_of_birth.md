# PE11: Number of patients by month stratified by day of birth

## Description
This query is used to count number of patients grouped by month of birth within all person records. All possible values for month of birth are summarized. Not all databases maintain month of birth. This query is only available from CDM V4 and above.

## Query
```sql
SELECT NVL(month_of_birth,1) AS month_of_year, count(*) AS num_records
FROM person
GROUP BY month_of_birth
ORDER BY 1;
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
|  month |  Month year 1 through 12 |
|  num_rows |  Number of records |

## Sample output record

| Field |  Value |
| --- | --- |
|  month |  1 |
|  num_rows |  34462921 |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
