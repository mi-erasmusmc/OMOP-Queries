C02: Find a condition by keyword
---
This query enables search of vocabulary entities by keyword. The query does a search of standard concepts names in the CONDITION domain (SNOMED-CT clinical findings and MedDRA concepts) and their synonyms to return all related concepts.

It does not require prior knowledge of where in the logic of the vocabularies the entity is situated.

Input:

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword |  'myocardial infarction' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

Sample query run:

The following is a sample run of the query to run a search of the Condition domain for keyword 'myocardial infarction'. The input parameters are highlighted in  blue.

```sql
SELECT
  t.entity_concept_id,
  t.entity_name,
  t.entity_code,
  t.entity_concept_class,
  t.entity_vocabulary_id
FROM (
       SELECT
         c.concept_id       AS entity_concept_id,
         c.concept_name     AS entity_name,
         c.concept_code     AS entity_code,
         c.concept_class_id AS entity_concept_class,
         c.vocabulary_id    AS entity_vocabulary_id,
         c.valid_start_date,
         c.valid_end_date
       FROM concept AS c
         LEFT JOIN concept_synonym AS s ON c.concept_id = s.concept_id
       WHERE
         (c.vocabulary_id IN ('SNOMED', 'MedDRA') OR lower(c.concept_class_id) = 'clinical finding') AND
         c.concept_class_id IS NOT NULL AND
         (lower(c.concept_name) LIKE '%myocardial infarction%' OR  -- PARAMETER
          lower(s.concept_synonym_name) LIKE '%myocardial infarction%')  -- PARAMETER
     ) t
WHERE sysdate BETWEEN valid_start_date AND valid_end_date -- PARAMETER
ORDER BY t.entity_vocabulary_id, t.entity_name
;
```

Output:

Output field list:

|  Field |  Description |
| --- | --- |
|  Entity_Concept_ID |  Concept ID of entity with string match on name or synonym concept |
|  Entity_Name |  Concept name of entity with string match on name or synonym concept |
|  Entity_Code |  Concept code of entity with string match on name or synonym concept  |
|  Entity_Type |  Concept type |
|  Entity_Concept_Class |  Concept class of entity with string match on name or synonym concept |
|  Entity_Vocabulary_ID |  ID of vocabulary associated with the concept |
|  Entity_Vocabulary_Name |  Name of the vocabulary associated with the concept |

Sample output record:

|  Field |  Value |
| --- | --- |
|  Entity_Concept_ID |  35205180 |
|  Entity_Name |  Acute myocardial infarction |
|  Entity_Code |  10000891 |
|  Entity_Type |  Concept |
|  Entity_Concept_Class |  Preferred Term |
|  Entity_Vocabulary_ID |  MedDRA |
|  Entity_Vocabulary_Name |  Medical Dictionary for Regulatory Activities (MSSO) |

This is a comprehensive query to find relevant terms in the vocabulary. To constrain, additional clauses can be added to the query. However, it is recommended to do a filtering after the result set is produced to avoid syntactical mistakes.

The query only returns concepts that are part of the Standard Vocabulary, ie. they have concept level that is not 0. If all concepts are needed, including the non-standard ones, the clause in the query restricting the concept level and concept class can be commented out.
