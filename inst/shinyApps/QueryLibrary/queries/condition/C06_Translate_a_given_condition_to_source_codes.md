# C06: Translate a given condition to source codes

## Description
This query allows to search all source codes that are mapped to a SNOMED-CT clinical finding concept. It can be used to translate SNOMED-CT to ICD-9-CM, ICD-10-CM, Read or OXMIS codes.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  SNOMED-CT Concept ID |  312327 |  Yes | Concept IDs are numeric. If more than one concept code needs to be translated an IN clause or a JOIN can be used. |
|  Source Vocabulary ID |  2 |  Yes | 2 represents ICD9-CM |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list all source codes that map to a SNOMED-CT concept entered as input. The sample parameter substitutions are highlighted in  blue.

```sql
SELECT DISTINCT
  c1.concept_code,
  c1.concept_name,
  c1.vocabulary_id source_vocabulary_id,
  VS.vocabulary_name source_vocabulary_description,
  C1.domain_id,
  C2.concept_id target_concept_id,
  C2.concept_name target_Concept_Name,
  C2.concept_code target_Concept_Code,
  C2.concept_class_id target_Concept_Class,
  C2.vocabulary_id target_Concept_Vocab_ID,
  VT.vocabulary_name target_Concept_Vocab_Name
FROM
  concept_relationship cr,
  concept c1,
  concept c2,
  vocabulary VS,
  vocabulary VT
WHERE
  cr.concept_id_1 = c1.concept_id AND
  cr.relationship_id = 'Maps to' AND
  cr.concept_id_2 = c2.concept_id AND
  c1.vocabulary_id = VS.vocabulary_id AND
  c1.domain_id = 'Condition' AND
  c2.vocabulary_id = VT.vocabulary_id AND
  c1.concept_id =
312327                                            
  AND c1.vocabulary_id =
'SNOMED'                                          
AND
sysdate                                           
BETWEEN c2.valid_start_date AND c2.valid_end_date;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  Source_Code |  Source code for the disease entered as input |
|  Source_Code_Description |  Description of the source code entered as input |
|  Source_Vocabulary_ID |  Vocabulary the disease source code is derived from as vocabulary code |
|  Source_Vocabulary_Description |  Name of the vocabulary the disease source code is derived from |
|  Mapping_Type |  Type of mapping or mapping domain, from source code to target concept. Example Condition, Procedure, Drug etc. |
|  Target_Concept_ID |  Concept ID of the SNOMED-CT concept entered as input |
|  Target_Concept_Name |  Name of the SNOMED-CT concept entered as input |
|  Target_Concept_Code |  Concept code of the SNOMED-CT concept entered as input |
|  Target_Concept_Class |  Concept class of the SNOMED-CT concept entered as input |
|  Target_Concept_Vocab_ID |  Vocabulary of concept entered as input is derived from, as vocabulary ID |
|  Target_Concept_Vocab_Name |  Name of vocabulary the concept entered as input is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Source_Code |  410.92 |
|  Source_Code_Description |  Acute myocardial infarction, unspecified site, subsequent episode of care |
|  Source_Vocabulary_ID |  SNOMED |
|  Source_Vocabulary_Description |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
|  Mapping_Type |  CONDITION |
|  Target_Concept_ID |  312327 |
|  Target_Concept_Name |  Acute myocardial infarction |
|  Target_Concept_Code |  57054005 |
|  Target_Concept_Class |  Clinical finding |
|  Target_Concept_Vocab_ID |  SNOMED |
|  Target_Concept_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
