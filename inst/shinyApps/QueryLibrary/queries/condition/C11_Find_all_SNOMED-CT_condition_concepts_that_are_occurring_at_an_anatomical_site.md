# C11: Find all SNOMED-CT condition concepts that are occurring at an anatomical site

## Description
This query accepts a SNOMED-CT body structure ID as input and returns all conditions occurring in the anatomical site, which can be identified using query  [C10](http://vocabqueries.omop.org/condition-queries/c10). Input:

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  SNOMED-CT Concept ID |  4103720 |  Yes | Concept Identifier for 'Posterior epiglottis' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list conditions located in the anatomical site.

```sql
SELECT
  A.concept_Id Condition_ID,
  A.concept_Name Condition_name,
  A.concept_Code Condition_code,
  A.concept_Class_id Condition_class,
  A.vocabulary_id Condition_vocab_ID,
  VA.vocabulary_name Condition_vocab_name,
  D.concept_Id Anatomical_site_ID,
  D.concept_Name Anatomical_site_Name,
  D.concept_Code Anatomical_site_Code,
  D.concept_Class_id Anatomical_site_Class,
  D.vocabulary_id Anatomical_site_vocab_ID,
  VS.vocabulary_name Anatomical_site_vocab_name
FROM
  concept_relationship CR,
  concept A,
  concept D,
  vocabulary VA,
  vocabulary VS
WHERE
  CR.relationship_ID = 'Has finding site' AND
  CR.concept_id_1 = A.concept_id AND
  A.vocabulary_id = VA.vocabulary_id AND
  CR.concept_id_2 = D.concept_id AND
  D.concept_id =
4103720                                             --input
  AND D.vocabulary_id = VS.vocabulary_id AND
sysdate                                             --input
  BETWEEN CR.valid_start_date AND CR.valid_end_date;
```

 Output: 

 Output field list:

|  Field |  Description |
| --- | --- |
|  Condition_ID |  Condition concept Identifier |
|  Condition_Name |  Name of the standard condition concept |
|  Condition_Code |  Concept code of the standard concept in the source vocabulary |
|  Condition_Class |  Concept class of standard vocabulary concept |
|  Condition_Vocab_ID |  Vocabulary the standard concept is derived from as vocabulary ID |
|  Condition_Vocab_Name |  Name of the vocabulary the standard concept is derived from |
|  Anatomical_Site_ID |  Body Structure ID entered as input |
|  Anatomical_Site_Name |  Body Structure Name |
|  Anatomical_Site_Code |  Concept Code of the body structure concept |
|  Anatomical_Site_Class |  Concept Class of the body structure concept |
|  Anatomical_Site_Vocab_ID |  Vocabulary the body structure concept is derived from as vocabulary code |
|  Anatomical_Site_Vocab_Name |  Name of the vocabulary the body structure concept is derived from |

 Sample output record:

|  Field |  Value |
| --- | --- |
|  Condition_ID |  4054522 |
|  Condition_Name |  Neoplasm of laryngeal surface of epiglottis |
|  Condition_Code |  126700009 |
|  Condition_Class |  Clinical finding |
|  Condition_Vocab_ID |  SNOMED |
|  Condition_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
|  Anatomical_Site_ID |  4103720 |
|  Anatomical_Site_Name |  Posterior epiglottis |
|  Anatomical_Site_Code |  2894003 |
|  Anatomical_Site_Class |  Body structure |
|  Anatomical_Site_Vocab_ID |  SNOMED |
|  Anatomical_Site_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
