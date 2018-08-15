# G04: Find synonyms for a given concept

This query extracts all synonyms in the vocabulary for a given Concept ID.

## Sample query
```sql
SELECT C.concept_id, S.concept_synonym_name
FROM concept C, concept_synonym S, vocabulary V
WHERE C.concept_id = 192671
AND C.concept_id = S.concept_id
AND C.vocabulary_id = V.vocabulary_id
AND sysdate BETWEEN C.valid_start_date AND C.valid_end_date;
```

### Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | GI - Gastrointestinal hemorrhage |
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
https://github.com/OHDSI/CommonDataModel/wiki/
