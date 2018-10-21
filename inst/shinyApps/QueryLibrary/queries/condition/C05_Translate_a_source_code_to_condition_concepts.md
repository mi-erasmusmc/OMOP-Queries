# C05: Translate a source code to condition concepts

## Description
This query enables to search all Standard SNOMED-CT concepts that are mapped to a condition (disease) source code. It can be used to translate e.g. ICD-9-CM, ICD-10-CM or Read codes to SNOMED-CT.

Source codes are not unique across different source vocabularies, therefore the source vocabulary ID must also be provided.

The following source vocabularies have condition/disease codes that map to SNOMED-CT concepts:

-  ICD-9-CM,    Vocabulary_id=2
- Read,            Vocabulary_id=17
- OXMIS,         Vocabulary_id=18
- ICD-10-CM,   Vocabulary_id=34

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Source Code List |  '070.0' |  Yes | Source codes are alphanumeric and need to be entered as a string enclosed by a single quote. If more than one source code needs to be entered an IN clause or a JOIN can be used. |
|  Source Vocabulary ID |  2 |  Yes | The source vocabulary is mandatory, because the source ID is not unique across different vocabularies. |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list SNOMED-CT concepts that a set of mapped codes entered as input map to. The sample parameter substitutions are highlighted in  blue 

```sql
set search_path to full_201612_omop_v5;
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
  c1.concept_code IN (
'070.0'                                           
) AND c2.vocabulary_id =
'SNOMED'                                          
AND
sysdate                                           
BETWEEN c1.valid_start_date AND c1.valid_end_date;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  Source_Code |  Source code for the disease entered as input |
|  Source_Code_Description |  Description of the source code entered as input |
|  Source_Vocabulary_ID |  Vocabulary the disease source code is derived from as vocabulary ID |
|  Source_Vocabulary_Description |  Name of the vocabulary the disease source code is derived from |
|  Mapping_Type |  Type of mapping or mapping domain, from source code to target concept. Example Condition, Procedure, Drug etc. |
|  Target_Concept_ID |  Concept ID of the target condition concept mapped to the disease source code |
|  Target_Concept_Name |  Name of the target condition concept mapped to the disease source code |
|  Target_Concept_Code |  Concept code of the target condition concept mapped to the disease source code |
|  Target_Concept_Class |  Concept class of the target condition concept mapped to the disease source code |
|  Target_Concept_Vocab_ID |  Vocabulary the target condition concept is derived from as vocabulary code |
|  Target_Concept_Vocab_Name |  Name of the vocabulary the condition concept is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Source_Code |  070.0 |
|  Source_Code_Description |  Viral hepatitis |
|  Source_Vocabulary_ID |  ICD9CM |
|  Source_Vocabulary_Description |  International Classification of Diseases, Ninth Revision, Clinical Modification, Volume 1 and 2 (NCHS) |
|  Mapping_Type |  CONDITION |
|  Target_Concept_ID |  4291005 |
|  Target_Concept_Name |  VH - Viral hepatitis |
|  Target_Concept_Code |  3738000 |
|  Target_Concept_Class |  Clinical finding |
|  Target_Concept_Vocab_ID |  SNOMED |
|  Target_Concept_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
