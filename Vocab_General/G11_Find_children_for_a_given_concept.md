G11: Find children for a given concept
---

This query lists all standard vocabulary concepts that are child concepts of a given concept entered as input. The query accepts a concept ID as the input and returns all concepts that are its immediate child concepts.

The query returns only the immediate child concepts that are directly linked to the input concept and not all descendants.

Sample query:


```sql
SELECT
  d.concept_id       AS child_concept_id,
  d.concept_name     AS child_concept_name,
  d.concept_code     AS child_concept_code,
  d.concept_class_id AS child_concept_class_id,
  d.vocabulary_id    AS child_concept_vocab_id
FROM concept_ancestor AS ca
  JOIN concept AS d ON ca.descendant_concept_id = d.concept_id
WHERE ca.min_levels_of_separation = 1
      AND ca.ancestor_concept_id = 192671 -- PARAMETER
      AND sysdate BETWEEN d.valid_start_date AND d.valid_end_date -- PARAMETER
;
```
Input:

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | GI - Gastrointestinal hemorrhage |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

Output:

|  Field |  Description |
| --- | --- |
|  Child_Concept_ID |  Concept ID of child concept entered as input |
|  Child_Concept_Name |  Name of child concept entered as input |
|  Child_Concept_Code |  Concept Code of child concept entered as input |
|  Child_Concept_Class |  Concept Class of child concept entered as input |
|  Child_Concept_Vocab_ID |  ID of the vocabulary the child concept is derived from |
|  Child_Concept_Vocab_Name |  Name of the vocabulary the child concept is derived from |

Sample output record:

|  Field |  Value |
| --- | --- |
|  Child_Concept_ID |  4128705 |
|  Child_Concept_Name |  Haemorrhagic enteritis |
|  Child_Concept_Code |  235224000 |
|  Child_Concept_Class |  Clinical finding |
|  Child_Concept_Vocab_ID |  1 |
|  Child_Concept_Vocab_Name |  SNOMED-CT |

