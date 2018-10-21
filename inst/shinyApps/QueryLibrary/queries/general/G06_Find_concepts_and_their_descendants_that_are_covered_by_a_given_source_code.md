# G06: Find concepts and their descendants that are covered by a given source code

## Description
This query returns all concepts that are direct maps and the descendants of these directly mapped concepts. This is useful if the target standard vocabulary is organized in a tall hierarchy, while the source vocabulary organization is flat.

Additional constraints can be added at the end of the query if only a specific target domain or target vocabulary is desired. For example, if only SNOMED-CT as the standard vocabulary for conditions needs be returned, the target vocabulary can be set to 1.

In the query only FDB indications and contraindications are returned, but not NDF-RT indications or contraindications. That is because no direct mapping between ICD-9-CM and NDF-RT exists. In order to query for drug indications please see queries D12 through D18.

## Query
```sql
WITH dm AS ( -- collect direct maps
SELECT  c1.concept_code as source_code,
        c1.vocabulary_id,
        c1.domain_id,
        c2.concept_id        as target_concept_id,
        c2.concept_name      as target_concept_name,
        c2.concept_code      as target_concept_code,
        c2.concept_class_id     as target_concept_class,
        c2.vocabulary_id     as target_concept_vocab_id,
        'Direct map'        as target_Type
FROM    concept_relationship cr
                JOIN concept c1 ON cr.concept_id_1 = c1.concept_id
                JOIN concept c2 ON cr.concept_id_2 = c2.concept_id
WHERE   cr.relationship_id = 'Maps to'
AND                c1.concept_code IN ('410.0')
AND     c1.vocabulary_id = 'ICD9CM'
AND     sysdate BETWEEN cr.valid_start_date AND cr.valid_end_date )
SELECT dm.source_code,
        dm.vocabulary_id,
        dm.domain_id,
        dc.concept_id        AS        target_concept_id,
        dc.concept_name        AS target_concept_name,
        dc.concept_code AS target_concept_code,
        dc.concept_class_id AS target_concept_class,
        dc.vocabulary_id AS target_concept_vocab_id,
    'Descendant of direct map' as target_Type
FROM concept_ancestor ca -- collect descendants which includes ancestor itself
JOIN dm ON ca.ancestor_concept_id = dm.target_concept_id
JOIN concept dc ON ca.descendant_concept_id = dc.concept_id
WHERE dc.standard_concept = 'S';
```

## Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Source Code List |  '410.0' |  Yes | Source codes are alphanumeric. |
|  Source Vocabulary ID |  2 |  Yes | 2 represents ICD9-CM.

The list of vocabulary codes can be found in the VOCABULARY table. |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

| Field |  Description |
| --- | --- |
|  Mapping_Type |  Type of mapping from source code to target concept |
|  Target_Concept_ID |  Concept ID of mapped concept |
|  Target_Concept_Name |  Concept name of mapped concept |
|  Target_Concept_Code |  Concept Code of mapped concept |
|  Target_Concept_Class |  Concept class of mapped concept |
|  Target_Concept_Vocab_ID |  ID of the target vocabulary |
|  Target_Concept_Vocab_Name |  Name of the vocabulary the target concept is part of |
|  Target_Type |   Type of result, indicates how the target concepts was extracted. Includes:
- Concepts that are direct maps
- Concepts that are descendants of direct maps
 |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Mapping_Type |  CONDITION |
|  Target_Concept_ID |  312327 |
|  Target_Concept_Name |  Acute myocardial infarction |
|  Target_Concept_Code |  57054005 |
|  Target_Concept_Class |  Clinical finding |
|  Target_Concept_Vocab_ID |  1 |
|  Target_Concept_Vocab_Name |  SNOMED-CT |
|  Target_Type |  Direct map |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
