C01: Find condition by concept ID
---
Find condition by condition ID is the lookup for obtaining condition or disease concept details associated with a concept identifier. This query is a tool for quick reference for the name, class, level and source vocabulary details associated with a concept identifier, either SNOMED-CT clinical finding or MedDRA.
This query is equivalent to  [G01](http://vocabqueries.omop.org/general-queries/g1), but if the concept is not in the condition domain the query still returns the concept details with the Is_Disease_Concept_Flag field set to 'No'.

Input:

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | Concept Identifier for 'GI - Gastrointestinal haemorrhage' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

Sample query run:

The following is a sample run of the query to run a search for specific disease concept ID.

The input parameters are highlighted in  blue.

```sql
SELECT
  c.concept_id       AS condition_concept_id,
  c.concept_name     AS condition_concept_name,
  c.concept_code     AS condition_concept_code,
  c.concept_class_id AS condition_concept_class,
  c.vocabulary_id    AS condition_concept_vocab_id,
  CASE c.vocabulary_id
    WHEN 'SNOMED'
      THEN CASE lower(c.concept_class_id)
           WHEN 'clinical finding'
             THEN 'Yes'
           ELSE 'No' END
    WHEN 'MedDRA'
      THEN 'Yes'
    ELSE 'No'
  END                AS is_disease_concept_flag
FROM concept AS c
WHERE
  c.concept_id = 192671 AND -- PARAMETER
  sysdate BETWEEN valid_start_date AND valid_end_date -- PARAMETER
;
```

Output:

Output field list:

|  Field |  Description |
| --- | --- |
|  Condition_Concept_ID |  Condition concept Identifier entered as input |
|  Condition_Concept_Name |  Name of the standard condition concept |
|  Condition_Concept_Code |  Concept code of the standard concept in the source vocabulary |
|  Condition_Concept_Class |  Concept class of standard vocabulary concept |
|  Condition_Concept_Vocab_ID  |  Vocabulary the standard concept is derived from as vocabulary code |
|  Condition_Concept_Vocab_Name |  Name of the vocabulary the standard concept is derived from |
|  Is_Disease_Concept_Flag |  Flag indicating whether the Concept ID belongs to a disease concept. 'Yes' if disease concept, 'No' if not a disease concept |

Sample output record:

|  Field |  Value |
| --- | --- |
|  Condition_Concept_ID |  192671 |
|  Condition_Concept_Name |  GI - Gastrointestinal hemorrhage |
|  Condition_Concept_Code |  74474003 |
|  Condition_Concept_Class |  Clinical finding |
|  Condition_Concept_Vocab_ID |  SNOMED |
|  Condition_Concept_Vocab_Name | Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
|  Is_Disease_Concept_Flag |  Yes |
