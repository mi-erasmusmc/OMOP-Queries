G09: Find descendants for a given concept
---

For a concept identifier entered as the input parameter, this query lists all descendants in the hierarchy of the domain. Descendant are concepts have a relationship to the given concept that is defined as hierarchical in the relationship table, and any secondary, tertiary etc. concepts going down in the hierarchy. The resulting output provides the descendant concept details and the minimum and maximum level of separation.

Sample query:


```sql
SELECT
  c.concept_id               AS descendant_concept_id,
  c.concept_name             AS descendant_concept_name,
  c.concept_code             AS descendant_concept_code,
  c.concept_class_id         AS descendant_concept_class_id,
  c.vocabulary_id            AS vocabulary_id,
  a.min_levels_of_separation AS min_separation,
  a.max_levels_of_separation AS max_separation
FROM concept_ancestor AS a
  JOIN concept AS c ON a.descendant_concept_id = c.concept_id
WHERE a.ancestor_concept_id <> a.descendant_concept_id
      AND a.ancestor_concept_id = 192671 -- PARAMETER
      AND sysdate BETWEEN valid_start_date AND valid_end_date -- PARAMETER
ORDER BY vocabulary_id, min_separation
;
```
Input:

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | GI - Gastrointestinal hemorrhage |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

Output:

| Field |  Description |
| --- | --- |
|  Descendant_Concept_ID |  Unique identifier of the concept related to the descendant concept |
|  Descendant_Concept_Name |  Name of the concept related to the descendant concept |
|  Descendant_Concept_Code |  Concept code of concept related to the descendant concept |
|  Descendant_Concept_Class |  Concept Class of concept related to the descendant concept |
|  Vocabulary_ID |  ID of the vocabulary the descendant concept is derived from |
|  Vocabulary_Name; |  Name of the vocabulary the descendant concept is derived from |
|  Min_Levels_of_Separation |  The length of the shortest path between the concept and the descendant |
|  Max_Levels_of_Separation |  The length of the longest path between the concept and the descendant |

Sample output record:

|  Field |  Value |
| --- | --- |
|  Descendant_Concept_ID |  4318535 |
|  Descendant_Concept_Name |  Duodenal haemorrhage |
|  Descendant_Concept_Code |  95533003 |
|  Descendant_Concept_Class |  Clinical finding |
|  Vocabulary_ID |  1 |
|  Vocabulary_Name |  SNOMED-CT |
|  Min_Levels_of_Separation |  1 |
|  Max_Levels_of_Separation |  1 |

