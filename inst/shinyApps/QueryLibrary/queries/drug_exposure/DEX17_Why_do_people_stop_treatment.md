# DEX17: Why do people stop treatment?

## Description
| This query provides a list of stop treatment and their frequency.

## Input <None>
## Query

The following is a sample run of the query. The input parameters are highlighted in  blue. S

```sql
SELECT stop_reason, count(*) AS reason_freq 
FROM drug_exposure 
WHERE 
stop_reason IS NOT null GROUP BY stop_reason ORDER BY reason_freq DESC;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- | 
| stop_reason | The reason the medication was stopped, where available. Reasons include regimen completed, changed, removed, etc. |
| reason_freq |  Frequency of stop reason |


## Sample output record

|  Field |  Description |
| --- | --- | 
| stop_reason |  Regimen Completed |
| reason_freq |  14712428 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
