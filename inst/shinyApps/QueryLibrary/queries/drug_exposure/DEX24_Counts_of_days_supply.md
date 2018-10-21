# DEX24: Counts of days supply

## Description
| This query is used to count days supply values across all drug exposure records. The input to the query is a value (or a comma-separated list of values) of a days_supply. If the clause is omitted, all possible values of days_supply are summarized.

## Input

|  Parameter |  Example |  Mandatory |  Notes | 
| --- | --- | --- | --- |
| days_supply | 2,3 | Yes |   | 

## Query
The following is a sample run of the query. The input parameters are highlighted in  blue.  

```sql
SELECT t.days_supply, count(1) AS cnt
FROM drug_exposure t
WHERE t.days_supply in (2,3) 
GROUP BY t.days_supply
ORDER BY days_supply;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- | 
| days_supply | The number of days of supply of the medication as recorded in the original prescription or dispensing record. |
| cnt | Counts of records with the days_supply value |

## Sample output record

|  Field |  Description |
| --- | --- | 
| days_supply |  15 |
| cnt |  240179 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
