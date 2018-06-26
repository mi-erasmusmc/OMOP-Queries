C07: Find a pathogen by keyword
---
This query enables a search of all pathogens using a keyword as input. The resulting concepts could be used in query  [C09](http://vocabqueries.omop.org/condition-queries/c9) to identify diseases caused by a certain pathogen.

Input:

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword for pathogen |  'Trypanosoma' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

Sample query run:

The following is a sample run of the query to list all pathogens specified using a keyword as input. The sample parameter substitutions are highlighted in  blue.

```sql
SELECT
  c.concept_id       AS pathogen_concept_id,
  c.concept_name     AS pathogen_concept_name,
  c.concept_code     AS pathogen_concept_code,
  c.concept_class_id AS pathogen_concept_class,
  c.standard_concept AS pathogen_standard_concept,
  c.vocabulary_id    AS pathogen_concept_vocab_id
FROM concept AS c
WHERE
  lower(c.concept_class_id) = 'organism' AND
  lower(c.concept_name) LIKE '%trypanosoma%' AND -- PARAMETER
  sysdate BETWEEN c.valid_start_date AND c.valid_end_date -- PARAMETER
;
```

Output:

Output field list:

|  Field |  Description |
| --- | --- |
|  Pathogen_Concept_ID |  Concept ID of SNOMED-CT pathogen concept |
|  Pathogen_Concept_Name |  Name of SNOMED-CT pathogen concept with keyword entered as input |
|  Pathogen_Concept_Code |  Concept Code of SNOMED-CT pathogen concept |
|  Pathogen_Concept_Class |  Concept class of SNOMED-CT pathogen concept |
|  Pathogen_Standard_Concept |  Indicator of standard concept of SNOMED-CT pathogen concept |
|  Pathogen_Vocab_ID |  Vocabulary ID of the vocabulary from which the pathogen concept is derived from (1 for SNOMED-CT) |
|  Pathogen_Vocab_Name |  Name of the vocabulary from which the pathogen concept is derived from (SNOMED-CT) |

Sample output record:

|  Field |  Value |
| --- | --- |
|  Pathogen_Concept_ID |  4085768 |
|  Pathogen_Concept_Name |  Trypanosoma brucei |
|  Pathogen_Concept_Code |  243659009 |
|  Pathogen_Concept_Class |  Organism |
| Pathogen_Standard_Concept |  S |
|  Pathogen_Vocab_ID |  SNOMED |
|  Pathogen_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
