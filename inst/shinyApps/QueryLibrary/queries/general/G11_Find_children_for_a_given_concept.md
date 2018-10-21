# G11: Find children for a given concept

## Description
This query lists all standard vocabulary concepts that are child concepts of a given concept entered as input. The query accepts a concept ID as the input and returns all concepts that are its immediate child concepts.

The query returns only the immediate child concepts that are directly linked to the input concept and not all descendants.

## Query
```sql
SELECT D.concept_id Child_concept_id, D.concept_name Child_concept_name, D.concept_code Child_concept_code, D.concept_class_id Child_concept_class_id, D.vocabulary_id Child_concept_vocab_ID, VS.vocabulary_name Child_concept_vocab_name
FROM concept_ancestor CA, concept D, vocabulary VS
WHERE CA.ancestor_concept_id = 192671
AND CA.min_levels_of_separation = 1
AND CA.descendant_concept_id = D.concept_id
AND D.vocabulary_id = VS.vocabulary_id
AND sysdate BETWEEN D.valid_start_date
AND D.valid_end_date;
```

## Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | GI - Gastrointestinal hemorrhage |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | --- |
|  Child_Concept_ID |  Concept ID of child concept entered as input |
|  Child_Concept_Name |  Name of child concept entered as input |
|  Child_Concept_Code |  Concept Code of child concept entered as input |
|  Child_Concept_Class |  Concept Class of child concept entered as input |
|  Child_Concept_Vocab_ID |  ID of the vocabulary the child concept is derived from |
|  Child_Concept_Vocab_Name |  Name of the vocabulary the child concept is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Child_Concept_ID |  4128705 |
|  Child_Concept_Name |  Haemorrhagic enteritis |
|  Child_Concept_Code |  235224000 |
|  Child_Concept_Class |  Clinical finding |
|  Child_Concept_Vocab_ID |  1 |
|  Child_Concept_Vocab_Name |  SNOMED-CT |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
