# G05: Translate a code from a source to a standard vocabulary.

## Description
This query enables search of all Standard Vocabulary concepts that are mapped to a code from a specified source vocabulary. It will return all possible concepts that are mapped to it, as well as the target vocabulary. The source code could be obtained using queries G02 or G03.
Note that to unambiguously identify a source code, the vocabulary id has to be provided, as source codes are not unique identifiers across different vocabularies.

## Query
```sql
SELECT DISTINCT
        c1.domain_id,
        c2.concept_id         as Concept_Id,
        c2.concept_name       as Concept_Name,
        c2.concept_code       as Concept_Code,
        c2.concept_class_id      as Concept_Class,
        c2.vocabulary_id      as Concept_Vocabulary_ID,
                  c2.domain_id                  as Target_concept_Domain
FROM concept_relationship cr
JOIN concept c1 ON c1.concept_id = cr.concept_id_1
JOIN concept c2 ON c2.concept_id = cr.concept_id_2
WHERE cr.relationship_id = 'Maps to'
AND c1.concept_code IN ('070.0')
AND c1.vocabulary_id = 'ICD9CM'
AND sysdate BETWEEN cr.valid_start_date AND cr.valid_end_date;
```

## Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Source Code List |  '070.0' |  Yes |  Source codes are alphanumeric |
|  Source Vocabulary ID |  2 |  Yes | The source vocabulary ID is mandatory, because the source code is not unique across different vocabularies.

The list of vocabulary codes is listed in the VOCABULARY table. Vocabulary ID of 2 represents ICD9-CM |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | --- |
|  Mapping_Type |  Type of mapping from source code to target concept |
|  Target_Concept_Id |  Concept ID of mapped concept |
|  Target_Concept_Name |  Name of mapped concept |
|  Target_Concept_Code |  Concept code of mapped concept |
|  Target_Concept_Class |  Class of the mapped concept |
|  Target_Concept_Vocab_ID |  Vocabulary ID of the target vocabulary |
|  Target_Concept_Vocab_Name |  Name of the vocabulary the target concept is part of |
|  Target_Concept_Domain |  Vocabulary domain that includes the entity. The domains include:
DRUG, CONDITION, PROCEDURE, OBSERVATION, OBSERVATION UNIT, VISIT, DEMOGRAPHIC, DEATH, COST, PROVIDER |

## Sample output record

| Field |  Value |
| --- | --- |
|  Mapping_Type |  CONDITION-MEDDRA |
|  Target_Concept_Id |  35909589 |
|  Target_Concept_Name |  Hepatitis viral |
|  Target_Concept_Code |  10019799 |
|  Target_Concept_Class |  Preferred Term |
|  Target_Concept_Vocab_ID |  15 |
|  Target_Concept_Vocab_Name |  MedDRA |
|  Target_Concept_Domain |  CONDITION |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
