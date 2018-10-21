# G01: Find concept by concept ID

## Description
This is the most generic look-up for obtaining concept details associated with a concept identifier. The query is intended as a tool for quick reference for the name, class, level and source vocabulary details associated with a concept identifier.

## Query
```sql
SELECT C.concept_id, C.concept_name, C.concept_code, C.concept_class_id, C.standard_concept, C.vocabulary_id, V.vocabulary_name
FROM concept C, vocabulary V
WHERE C.concept_id = 192671
AND C.vocabulary_id = V.vocabulary_id
AND sysdate BETWEEN valid_start_date
AND valid_end_date;
```

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | Concept Identifier for "GI - Gastrointestinal hemorrhage" |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | --- |
|  Concept_ID |  Concept Identifier entered as input |
|  Concept_Name |  Name of the standard concept |
|  Concept_Code |  Concept code of the standard concept in the source vocabulary |
|  Concept_Class |  Concept class of standard vocabulary concept |
|  Concept_Level |  Level of the concept if defined as part of a hierarchy |
|  Vocabulary_ID |  Vocabulary the standard concept is derived from as vocabulary code |
|  Vocabulary_Name |  Name of the vocabulary the standard concept is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Concept_ID |  192671 |
|  Concept_Name |  GI - Gastrointestinal haemorrhage |
|  Concept_Code |  74474003 |
|  Concept_Class |  Clinical finding |
|  Concept_Level |  2 |
|  Vocabulary_ID |  1 |
|  Vocabulary_Name |  SNOMED-CT |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
