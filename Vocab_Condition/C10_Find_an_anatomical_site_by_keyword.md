# C10: Find an anatomical site by keyword

This query enables a search of all anatomical sites using a keyword entered as input. The resulting concepts could be used in query  [C11](http://vocabqueries.omop.org/condition-queries/c11) to identify diseases occurring at a certain anatomical site.

## Sample query

The following is a sample run of the query to list all anatomical site concept IDs specified using a keyword as input. The sample parameter substitutions are highlighted in  blue.

```sql
SELECT
  c.concept_id       AS anatomical_site_id,
  c.concept_name     AS anatomical_site_name,
  c.concept_code     AS anatomical_site_code,
  c.concept_class_id AS anatomical_site_class,
  c.standard_concept AS anatomical_standard_concept,
  c.vocabulary_id    AS anatomical_site_vocab_id
FROM concept AS c
WHERE
  lower(c.concept_class_id) = 'body structure' AND
  lower(c.concept_name) LIKE '%epiglottis%' AND -- PARAMETER
  sysdate BETWEEN c.valid_start_date AND c.valid_end_date -- PARAMETER
;
```

### Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword for pathogen |  'Epiglottis' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

### Output

|  Field |  Description |
| --- | --- |
|  Anatomical_site_ID |  Concept ID of SNOMED-CT anatomical site concept |
|  Anatomical_site_Name |  Name of SNOMED-CT anatomical site concept entered as input |
|  Anatomical_site_Code |  Concept Code of SNOMED-CT anatomical site concept |
|  Anatomical_site_Class |  Concept class of SNOMED-CT anatomical site |
|  Anatomical_standard_concept |  Indicator of standard concept for SNOMED-CT anatomical site |
|  Anatomical_site_vocab_ID |  Vocabulary ID of the vocabulary from which the anatomical site  concept is derived from |

### Sample output record

|  Field |  Value |
| --- | --- |
|  Anatomical_site_ID |  4103720 |
|  Anatomical_site_Name |  Posterior epiglottis |
|  Anatomical_site_Code |  2894003 |
|  Anatomical_site_Class |  Body structure |
|  Anatomical_standard_concept |  S |
|  Anatomical_site_vocab_ID |  SNOMED |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT
