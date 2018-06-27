# P02: Find a procedure from a keyword.

This query enables search of procedure domain of the vocabulary by keyword. The query does a search of standard concepts names in the PROCEDURE domain (SNOMED-CT procedures, ICD9 procedures, CPT procedures and HCPCS procedures) and their synonyms to return all related concepts.

This is a comprehensive query to find relevant terms in the vocabulary. It does not require prior knowledge of where in the logic of the vocabularies the entity is situated. To constrain, additional clauses can be added to the query. However, it is recommended to do a filtering after the result set is produced to avoid syntactical mistakes.
The query only returns concepts that are part of the Standard Vocabulary, ie. they have concept level that is not 0. If all concepts are needed, including the non-standard ones, the clause in the query restricting the concept level and concept class can be commented out.

## Sample query

```sql
SELECT
  c.concept_id       AS entity_concept_id,
  c.concept_name     AS entity_name,
  c.concept_code     AS entity_code,
  c.concept_class_id AS entity_concept_class_id,
  c.vocabulary_id    AS entity_vocabulary_id
FROM concept AS c
  LEFT JOIN concept_synonym AS s ON c.concept_id = s.concept_id
WHERE (
        c.vocabulary_id IN ('ICD9Proc', 'CPT4', 'HCPCS')
        OR LOWER(c.concept_class_id) LIKE 'procedure'
      )
      AND c.concept_class_id IS NOT NULL
      AND c.standard_concept = 'S'
      AND (
        LOWER(c.concept_name) LIKE '%artery bypass%' -- PARAMETER
        OR LOWER(s.concept_synonym_name) LIKE '%artery bypass%' -- PARAMETER
      )
      AND sysdate BETWEEN c.valid_start_date AND c.valid_end_date -- PARAMETER
;
```

### Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword |  'artery bypass' |  Yes | Procedure keyword search |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

### Output

|  Field |  Description |
| --- | --- |
|  Entity_Concept_ID |  Concept ID of entity with string match on name or synonym concept |
|  Entity_Name |  Concept name of entity with string match on name or synonym concept |
|  Entity_Code |  Concept code of entity with string match on name or synonym concept |
|  Entity_Concept_Class |  Concept class of entity with string match on name or synonym concept |
|  Entity_Vocabulary_ID |  Vocabulary the concept with string match is derived from as vocabulary ID |

### Sample output record

| Field |  Value |
| --- | --- |
|  Entity_Concept_ID |  2107223 |
|  Entity_Name |  Coronary artery bypass, using venous graft(s) and arterial graft(s); two venous grafts (List separately in addition to code for primary procedure) |
|  Entity_Code |  33518 |
|  Entity_Concept_Class |  CPT-4 |
|  Entity_Vocabulary_ID |  CPT-4 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT_SYNONYM
