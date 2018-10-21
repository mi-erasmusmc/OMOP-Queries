# C02: Find a condition by keyword

## Description
This query enables search of vocabulary entities by keyword. The query does a search of standard concepts names in the CONDITION domain (SNOMED-CT clinical findings and MedDRA concepts) and their synonyms to return all related concepts.

It does not require prior knowledge of where in the logic of the vocabularies the entity is situated.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword |  'myocardial infarction' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to run a search of the Condition domain for keyword 'myocardial infarction'. The input parameters are highlighted in  blue.

```sql
SELECT 
  T.Entity_Concept_Id, 
  T.Entity_Name, 
  T.Entity_Code, 
  T.Entity_Type, 
  T.Entity_concept_class, 
  T.Entity_vocabulary_id, 
  T.Entity_vocabulary_name 
FROM ( 
  SELECT 
    C.concept_id Entity_Concept_Id, 
    C.concept_name Entity_Name, 
    C.CONCEPT_CODE Entity_Code, 
    'Concept' Entity_Type, 
    C.concept_class_id Entity_concept_class, 
    C.vocabulary_id Entity_vocabulary_id, 
    V.vocabulary_name Entity_vocabulary_name, 
    NULL Entity_Mapping_Type, 
    C.valid_start_date, 
    C.valid_end_date 
  FROM concept C 
  JOIN vocabulary V ON C.vocabulary_id = V.vocabulary_id 
  LEFT JOIN concept_synonym S ON C.concept_id = S.concept_id 
  WHERE 
    (C.vocabulary_id IN ('SNOMED', 'MedDRA') OR LOWER(C.concept_class_id) = 'clinical finding' ) AND 
    C.concept_class_id IS NOT NULL AND 
    ( LOWER(C.concept_name) like '%myocardial infarction%' OR 
      LOWER(S.concept_synonym_name) like '%myocardial infarction%' ) 
  ) T
WHERE sysdate BETWEEN valid_start_date AND valid_end_date 
ORDER BY 6,2;
```


## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  Entity_Concept_ID |  Concept ID of entity with string match on name or synonym concept |
|  Entity_Name |  Concept name of entity with string match on name or synonym concept |
|  Entity_Code |  Concept code of entity with string match on name or synonym concept  |
|  Entity_Type |  Concept type |
|  Entity_Concept_Class |  Concept class of entity with string match on name or synonym concept |
|  Entity_Vocabulary_ID |  ID of vocabulary associated with the concept |
|  Entity_Vocabulary_Name |  Name of the vocabulary associated with the concept |


## Sample output record

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

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
