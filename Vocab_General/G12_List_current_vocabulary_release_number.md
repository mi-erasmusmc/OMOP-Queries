# G12: List current vocabulary release number

This query returns current vocabulary release number.

## Sample query

```sql
SELECT  
  vocabulary_version
FROM vocabulary
WHERE vocabulary_id = 'None'
;
```
### Input

None

### Output

| Field |  Description |
| --- | --- |
|  vocabulary_version |  Version number of current OMOP vocabulary release |

### Sample output record

| Field |  Value |
| --- | --- |
|  vocabulary_version |  v5.0 28-MAR-17 |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/VOCABULARY
