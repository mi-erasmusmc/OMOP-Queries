# G04: Find synonyms for a given concept

This query extracts all synonyms in the vocabulary for a given Concept ID.

## Sample query

```sql
SELECT
  c.concept_id,
  s.concept_synonym_name
FROM concept AS c
  JOIN concept_synonym AS s ON c.concept_id = s.concept_id
WHERE c.concept_id = 192671 -- PARAMETER
      AND sysdate BETWEEN c.valid_start_date AND c.valid_end_date -- PARAMETER
;
```
### Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | Gastrointestinal hemorrhage |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

### Output

|  Field |  Description |
| --- | --- |
|  Concept_ID |  Unique identifier of the concept related to the input concept |
|  Concept_Synonym_Name |  Synonym of the concept |

### Sample output record

|  Field |  Value |
| --- | --- |
|  Concept_ID |  192671 |
|  Concept_Synonym_Name |  GI bleeding |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT_SYNONYM
