# C07: Find a pathogen by keyword

## Description
This query enables a search of all pathogens using a keyword as input. The resulting concepts could be used in query  [C09](http://vocabqueries.omop.org/condition-queries/c9) to identify diseases caused by a certain pathogen.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword for pathogen |  'Trypanosoma' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list all pathogens specified using a keyword as input. The sample parameter substitutions are highlighted in  blue.

```sql
SELECT 
  C.concept_id Pathogen_Concept_ID, 
  C.concept_name Pathogen_Concept_Name, 
  C.concept_code Pathogen_concept_code, 
  C.concept_class_id Pathogen_concept_class, 
  C.standard_concept Pathogen_Standard_Concept, 
  C.vocabulary_id Pathogen_Concept_Vocab_ID, 
  V.vocabulary_name Pathogen_Concept_Vocab_Name 
FROM 
  concept C, 
  vocabulary V
WHERE 
  LOWER(C.concept_class_id) = 'organism' AND 
  LOWER(C.concept_name) like
'%trypanosoma%'                                
AND C.vocabulary_id = V.vocabulary_id AND
sysdate                                        
BETWEEN C.valid_start_date AND C.valid_end_date;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  Pathogen_Concept_ID |  Concept ID of SNOMED-CT pathogen concept |
|  Pathogen_Concept_Name |  Name of SNOMED-CT pathogen concept with keyword entered as input |
|  Pathogen_Concept_Code |  Concept Code of SNOMED-CT pathogen concept |
|  Pathogen_Concept_Class |  Concept class of SNOMED-CT pathogen concept |
|  Pathogen_Standard_Concept |  Indicator of standard concept of SNOMED-CT pathogen concept |
|  Pathogen_Vocab_ID |  Vocabulary ID of the vocabulary from which the pathogen concept is derived from (1 for SNOMED-CT) |
|  Pathogen_Vocab_Name |  Name of the vocabulary from which the pathogen concept is derived from (SNOMED-CT) |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Pathogen_Concept_ID |  4085768 |
|  Pathogen_Concept_Name |  Trypanosoma brucei |
|  Pathogen_Concept_Code |  243659009 |
|  Pathogen_Concept_Class |  Organism |
| Pathogen_Standard_Concept |  S |
|  Pathogen_Vocab_ID |  SNOMED |
|  Pathogen_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
