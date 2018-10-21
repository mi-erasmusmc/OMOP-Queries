# C03: Translate a SNOMED-CT concept into a MedDRA concept

## Description
This query accepts a SNOMED-CT concept ID as input and returns details of the equivalent MedDRA concepts.

The relationships in the vocabulary associate MedDRA 'Preferred Term' to SNOMED-CT 'clinical findings'. The respective hierarchy for MedDRA and SNOMED-CT can be used to traverse up and down the hierarchy of each of these individual vocabularies.

Also, not all SNOMED-CT clinical findings are mapped to a MedDRA concept in the vocabulary.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  SNOMED-CT Concept ID |  312327 |  Yes | Concept Identifier for 'Acute myocardial infarction' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list MedDRA equivalents for SNOMED-CT concept whose concept ID is entered as input. 

```sql
SELECT    D.concept_id Snomed_concept_id,
        D.concept_name Snomed_concept_name,
        D.concept_code Snomed_concept_code,
        D.concept_class_id Snomed_concept_class,
        CR.relationship_id,
        RT.relationship_name,
        A.Concept_id MedDRA_concept_id,
        A.Concept_name MedDRA_concept_name,
        A.Concept_code MedDRA_concept_code,
        A.Concept_class_id MedDRA_concept_class 
FROM concept_relationship CR, concept A, concept D, relationship RT 
WHERE CR.relationship_id =  'SNOMED - MedDRA eq'
AND CR.concept_id_2 = A.concept_id 
AND CR.concept_id_1 = 312327
AND CR.concept_id_1 = D.concept_id 
AND CR.relationship_id = RT.relationship_id 
AND sysdate BETWEEN CR.valid_start_date 
AND CR.valid_end_date;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  SNOMED-CT_Concept_ID |  Concept ID of SNOMED-CT concept entered as input |
|  SNOMED-CT_Concept_Name |  Name of SNOMED-CT concept |
|  SNOMED-CT_Concept_Code |  Concept code of SNOMED-CT concept |
|  SNOMED-CT_Concept_Class |  Concept class of SNOMED-CT concept |
|  Relationship_ID |  Identifier for the type of relationship |
|  Relationship_Name |  Description of the type of relationship |
|  MedDRA_Concept_ID |  Concept ID of matching MedDRA concept |
|  MedDRA_Concept_Name |  Concept name of matching MedDRA concept |
|  MedDRA_Concept_Code |  Concept code of matching MedDRA concept |
|  MedDRA_Concept_Class |  Concept class of matching MedDRA concept |

## Sample output record

|  Field |  Value |
| --- | --- |
|  SNOMED-CT_Concept_ID |  312327 |
|  SNOMED-CT_Concept_Name |  Acute myocardial infarction |
|  SNOMED-CT_Concept_Code |  57054005 |
|  SNOMED-CT_Concept_Class |  Clinical finding |
|  Relationship_ID |  SNOMED - MedDRA eq |
|  Relationship_Name |  SNOMED-CT to MedDRA equivalent (OMOP) |
|  MedDRA_Concept_ID |  35205180 |
|  MedDRA_Concept_Name |  Acute myocardial infarction |
|  MedDRA_Concept_Code |  10000891 |
|  MedDRA_Concept_Class |  Preferred Term |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
