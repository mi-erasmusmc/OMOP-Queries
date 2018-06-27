# C11: Find all SNOMED-CT condition concepts that are occurring at an anatomical site

This query accepts a SNOMED-CT body structure ID as input and returns all conditions occurring in the anatomical site, which can be identified using query  [C10](http://vocabqueries.omop.org/condition-queries/c10). Input:

## Sample query

The following is a sample run of the query to list conditions located in the anatomical site.

```sql
SELECT
  a.concept_id       AS condition_id,
  a.concept_name     AS condition_name,
  a.concept_code     AS condition_code,
  a.concept_class_id AS condition_class,
  a.vocabulary_id    AS condition_vocab_id,
  d.concept_id       AS anatomical_site_id,
  d.concept_name     AS anatomical_site_name,
  d.concept_code     AS anatomical_site_code,
  d.concept_class_id AS anatomical_site_class,
  d.vocabulary_id    AS anatomical_site_vocab_id
FROM concept_relationship AS cr
  JOIN concept AS a ON cr.concept_id_1 = a.concept_id
  JOIN concept AS d ON cr.concept_id_2 = d.concept_id
WHERE
  cr.relationship_id = 'Has finding site' AND
  d.concept_id = 4103720 AND -- PARAMETER
  sysdate BETWEEN cr.valid_start_date AND cr.valid_end_date -- PARAMETER
;
```

### Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  SNOMED-CT Concept ID |  4103720 |  Yes | Concept Identifier for 'Posterior epiglottis' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

### Output

#### Output field list

|  Field |  Description |
| --- | --- |
|  Condition_ID |  Condition concept Identifier |
|  Condition_Name |  Name of the standard condition concept |
|  Condition_Code |  Concept code of the standard concept in the source vocabulary |
|  Condition_Class |  Concept class of standard vocabulary concept |
|  Condition_Vocab_ID |  Vocabulary the standard concept is derived from as vocabulary ID |
|  Anatomical_Site_ID |  Body Structure ID entered as input |
|  Anatomical_Site_Name |  Body Structure Name |
|  Anatomical_Site_Code |  Concept Code of the body structure concept |
|  Anatomical_Site_Class |  Concept Class of the body structure concept |
|  Anatomical_Site_Vocab_ID |  Vocabulary the body structure concept is derived from as vocabulary code |

#### Sample output record

|  Field |  Value |
| --- | --- |
|  Condition_ID |  4054522 |
|  Condition_Name |  Neoplasm of laryngeal surface of epiglottis |
|  Condition_Code |  126700009 |
|  Condition_Class |  Clinical finding |
|  Condition_Vocab_ID |  SNOMED |
|  Anatomical_Site_ID |  4103720 |
|  Anatomical_Site_Name |  Posterior epiglottis |
|  Anatomical_Site_Code |  2894003 |
|  Anatomical_Site_Class |  Body structure |
|  Anatomical_Site_Vocab_ID |  SNOMED |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT_RELATIONSHIP
