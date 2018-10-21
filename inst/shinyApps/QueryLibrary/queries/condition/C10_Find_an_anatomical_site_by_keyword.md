# C10: Find an anatomical site by keyword

## Description
This query enables a search of all anatomical sites using a keyword entered as input. The resulting concepts could be used in query  [C11](http://vocabqueries.omop.org/condition-queries/c11) to identify diseases occurring at a certain anatomical site.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword for pathogen |  'Epiglottis' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list all anatomical site concept IDs specified using a keyword as input. The sample parameter substitutions are highlighted in  blue.

```sql
SELECT 
  C.concept_id Anatomical_site_ID, 
  C.concept_name Anatomical_site_Name, 
  C.concept_code Anatomical_site_Code, 
  C.concept_class_id Anatomical_site_Class, 
  C.standard_concept Anatomical_standard_concept, 
  C.vocabulary_id Anatomical_site_Vocab_ID, 
  V.vocabulary_name Anatomical_site_Vocab_Name 
FROM 
  concept C, 
  vocabulary V 
WHERE 
  LOWER(C.concept_class_id) = 'body structure' AND 
  LOWER(C.concept_name) like
'%epiglottis%'                                  
AND C.vocabulary_id = V.vocabulary_id AND
sysdate                                          
BETWEEN C.valid_start_date AND C.valid_end_date;
```

## Output

|  Field |  Description |
| --- | --- |
|  Anatomical_site_ID |  Concept ID of SNOMED-CT anatomical site concept |
|  Anatomical_site_Name |  Name of SNOMED-CT anatomical site concept entered as input |
|  Anatomical_site_Code |  Concept Code of SNOMED-CT anatomical site concept |
|  Anatomical_site_Class |  Concept class of SNOMED-CT anatomical site |
|  Anatomical_standard_concept |  Indicator of standard concept for SNOMED-CT anatomical site |
|  Anatomical_site_vocab_ID |  Vocabulary ID of the vocabulary from which the anatomical site  concept is derived from |
|  Anatomical_site_vocab_name |  Name of the vocabulary from which the anatomical site concept is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Anatomical_site_ID |  4103720 |
|  Anatomical_site_Name |  Posterior epiglottis |
|  Anatomical_site_Code |  2894003 |
|  Anatomical_site_Class |  Body structure |
|  Anatomical_standard_concept |  S |
|  Anatomical_site_vocab_ID |  SNOMED 1 |
|  Anatomical_site_vocab_name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
