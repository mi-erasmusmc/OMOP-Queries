# C04: Translate a MedDRA concept into a SNOMED-CT concept

## Description
This query accepts a MedDRA concept ID as input and returns details of the equivalent SNOMED-CT concepts.
The existing relationships in the vocabulary associate MedDRA 'Preferred Term' to SNOMED-CT 'clinical findings'. The respective hierarchy for MedDRA and SNOMED-CT can be used to traverse up and down the hierarchy of each of these individual vocabularies.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  MedDRA Concept ID |  35205180 |  Yes | Concept Identifier for 'Acute myocardial infarction' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list all MedDRA concepts that have SNOMED-CT equivalents. Sample parameter substitution is highlighted in  blue.

```sql
SELECT    D.concept_id MedDRA_concept_id,
        D.concept_name MedDRA_concept_name,
        D.concept_code MedDRA_concept_code,
        D.concept_class_id MedDRA_concept_class,
        CR.relationship_id,
        RT.relationship_name,
        A.concept_id Snomed_concept_id,
        A.concept_name Snomed_concept_name,
        A.concept_code Snomed_concept_code,
        A.concept_class_id Snomed_concept_class 
FROM concept_relationship CR, concept A, concept D, relationship RT 
WHERE CR.relationship_id = 'MedDRA to SNOMED equivalent (OMOP)'
AND CR.concept_id_2 = A.concept_id 
AND CR.concept_id_1 = 35205180
AND CR.concept_id_1 = D.concept_id 
AND CR.relationship_id = RT.relationship_id 
AND sysdate BETWEEN CR.valid_start_date 
AND CR.valid_end_date;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  MedDRA_Concept_ID |  Concept ID of MedDRA concept entered as input |
|  MedDRA_Concept_Name |  Concept name of MedDRA concept |
|  MedDRA_Concept_Code |  Concept code of MedDRA concept |
|  MedDRA_Concept_Class |  Concept class of MedDRA concept |
|  Relationship_ID |  Identifier for the type of relationship |
|  Relationship_Name |  Description of the type of relationship |
|  SNOMED-CT_Concept_ID |  Concept ID of matching SNOMED-CT concept |
|  SNOMED-CT_Concept_Name |  Name of matching SNOMED-CT concept |
|  SNOMED-CT_Concept_Code |  Concept Code of matching SNOMED-CT concept |
|  SNOMED-CT_Concept_Class |  Concept class of matching SNOMED-CT concept |

## Sample output record

|  Field |  Value |
| --- | --- |
|  MedDRA_Concept_ID |  35205180 |
|  MedDRA_Concept_Name |  Acute myocardial infarction |
|  MedDRA_Concept_Code |  10000891 |
|  MedDRA_Concept_Class |  Preferred Term |
|  Relationship_ID |  MedDRA to SNOMED equivalent (OMOP) |
|  Relationship_Name |  MedDRA to SNOMED-CT equivalent (OMOP) |
|  SNOMED-CT_Concept_ID |  312327 |
|  SNOMED-CT_Concept_Name |  Acute myocardial infarction |
|  SNOMED-CT_Concept_Code |  57054005 |
|  SNOMED-CT_Concept_Class |  Clinical finding |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
