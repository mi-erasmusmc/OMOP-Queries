# G13: List available vocabularies

This query returns list of available vocabularies.

## Sample query

```sql
SELECT
  vocabulary_id,
  vocabulary_name,
  vocabulary_version
FROM vocabulary
;
```
### Input

None

### Output

| Field |  Description |
| --- | --- |
|  vocabulary_id |  OMOP Vocabulary ID |
|  vocabulary_name |  Vocabulary name |
|  vocabulary_version |  Version number of the loaded vocabulary |

### Sample output record

| Field |  Value |
| --- | --- |
|  vocabulary_id |  SNOMED |
|  vocabulary_name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
|  vocabulary_version |  SnomedCT Release 20170131 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/VOCABULARY
