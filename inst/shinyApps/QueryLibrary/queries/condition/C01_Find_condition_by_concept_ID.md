# C01: Find condition by concept ID

## Description
Find condition by condition ID is the lookup for obtaining condition or disease concept details associated with a concept identifier. This query is a tool for quick reference for the name, class, level and source vocabulary details associated with a concept identifier, either SNOMED-CT clinical finding or MedDRA.
This query is equivalent to  [G01](http://vocabqueries.omop.org/general-queries/g1), but if the concept is not in the condition domain the query still returns the concept details with the Is_Disease_Concept_Flag field set to 'No'.

## Query
The following is a sample run of the query to run a search for specific disease concept ID. 

The input parameters are highlighted in  blue.

```sql
SELECT 
  C.concept_id Condition_concept_id, 
  C.concept_name Condition_concept_name, 
  C.concept_code Condition_concept_code, 
  C.concept_class_id Condition_concept_class,
  C.vocabulary_id Condition_concept_vocab_ID, 
  V.vocabulary_name Condition_concept_vocab_name, 
  CASE C.vocabulary_id 
    WHEN 'SNOMED' THEN CASE lower(C.concept_class_id)   
      WHEN 'clinical finding' THEN 'Yes' ELSE 'No' END 
    WHEN 'MedDRA' THEN 'Yes'
    ELSE 'No' 
  END Is_Disease_Concept_flag 
FROM @cdm.concept C, @vocab.vocabulary V 
WHERE 
  C.concept_id = 192671 AND 
  C.vocabulary_id = V.vocabulary_id AND 
  sysdate BETWEEN valid_start_date AND valid_end_date;
```

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | ------------------------------------------- |
|  Concept ID |  192671 |  Yes | Concept Identifier for 'GI - Gastrointestinal haemorrhage' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | ----------------------------------------------- |
|  Condition_Concept_ID |  Condition concept Identifier entered as input |
|  Condition_Concept_Name |  Name of the standard condition concept |
|  Condition_Concept_Code |  Concept code of the standard concept in the source vocabulary |
|  Condition_Concept_Class |  Concept class of standard vocabulary concept |
|  Condition_Concept_Vocab_ID  |  Vocabulary the standard concept is derived from as vocabulary code |
|  Condition_Concept_Vocab_Name |  Name of the vocabulary the standard concept is derived from |
|  Is_Disease_Concept_Flag |  Flag indicating whether the Concept ID belongs to a disease concept. 'Yes' if disease concept, 'No' if not a disease concept |


## Sample output record

|  Field |  Value |
| --- | ----------------------------------------------- |
|  Condition_Concept_ID |  192671 |
|  Condition_Concept_Name |  GI - Gastrointestinal hemorrhage |
|  Condition_Concept_Code |  74474003 |
|  Condition_Concept_Class |  Clinical finding |
|  Condition_Concept_Vocab_ID |  SNOMED |
|  Condition_Concept_Vocab_Name | Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
|  Is_Disease_Concept_Flag |  Yes |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
