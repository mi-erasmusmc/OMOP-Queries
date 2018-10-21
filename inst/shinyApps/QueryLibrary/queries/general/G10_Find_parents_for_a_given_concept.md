# G10: Find parents for a given concept

## Description
This query accepts a concept ID as the input and returns all concepts that are its immediate parents of that concept. Parents are concepts that have a hierarchical relationship to the given concepts. Hierarchical relationships are defined in the relationship table.
The query returns only the immediate parent concepts that are directly linked to the input concept and not all ancestors.

## Query
```sql
SELECT A.concept_id Parent_concept_id, A.concept_name Parent_concept_name, A.concept_code Parent_concept_code, A.concept_class_id Parent_concept_class_id, A.vocabulary_id Parent_concept_vocab_ID, VA.vocabulary_name Parent_concept_vocab_name
FROM concept_ancestor CA, concept A, concept D, vocabulary VA
WHERE CA.descendant_concept_id = 192671
AND CA.min_levels_of_separation = 1
AND CA.ancestor_concept_id = A.concept_id
AND A.vocabulary_id = VA.vocabulary_id
AND CA.descendant_concept_id = D.concept_id
AND sysdate BETWEEN A.valid_start_date
AND A.valid_end_date;
```

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | GI - Gastrointestinal hemorrhage |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | --- |
|  Parent_Concept_ID |  Concept ID of parent concept |
|  Parent_Concept_Name |  Name of parent concept |
|  Parent_Concept_Code |  Concept Code of parent concept |
|  Parent_Concept_Class |  Concept Class of parent concept |
|  Parent_Concept_Vocab_ID |  Vocabulary parent concept is derived from as vocabulary code |
|  Parent_Concept_Vocab_Name |  Name of the vocabulary the child concept is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Parent_Concept_ID |  4000610 |
|  Parent_Concept_Name |  Disease of gastrointestinal tract |
|  Parent_Concept_Code |  119292006 |
|  Parent_Concept_Class |  Clinical finding |
|  Parent_Concept_Vocab_ID |  1 |
|  Parent_Concept_Vocab_Name |  SNOMED-CT |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
