# G09: Find descendants for a given concept

## Description
For a concept identifier entered as the input parameter, this query lists all descendants in the hierarchy of the domain. Descendant are concepts have a relationship to the given concept that is defined as hierarchical in the relationship table, and any secondary, tertiary etc. concepts going down in the hierarchy. The resulting output provides the descendant concept details and the minimum and maximum level of separation.

## Query
```sql
SELECT C.concept_id as descendant_concept_id, C.concept_name as descendant_concept_name, C.concept_code as descendant_concept_code, C.concept_class_id as descendant_concept_class_id, C.vocabulary_id, VA.vocabulary_name, A.min_levels_of_separation, A.max_levels_of_separation
FROM concept_ancestor A, concept C, vocabulary VA
WHERE A.descendant_concept_id = C.concept_id
AND C.vocabulary_id = VA.vocabulary_id
AND A.ancestor_concept_id <> A.descendant_concept_id
AND A.ancestor_concept_id = 192671
AND sysdate BETWEEN valid_start_date
AND valid_end_date
ORDER BY 5,7;
```

## Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | GI - Gastrointestinal hemorrhage |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

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

## Sample output record

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

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
