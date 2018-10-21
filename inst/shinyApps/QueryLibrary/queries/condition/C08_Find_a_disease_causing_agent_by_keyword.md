# C08: Find a disease causing agent by keyword

## Description
This query enables a search of various agents that can cause disease by keyword as input. Apart from pathogens (see query  [C07](http://vocabqueries.omop.org/condition-queries/c7)), these agents can be SNOMED-CT concepts of the following classes:
- Pharmaceutical / biologic product
- Physical object
- Special concept
- Event
- Physical force
- Substance

The resulting concepts could be used in query  [C09](http://vocabqueries.omop.org/condition-queries/c9) to identify diseases caused by the agent.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword for pathogen |  'Radiation' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list all pathogens specified using a keyword as input. The sample parameter substitutions are highlighted in  blue.

```sql
SELECT
  C.concept_id Agent_Concept_ID,
  C.concept_name Agent_Concept_Name,
  C.concept_code Agent_concept_code,
  C.concept_class_id Agent_concept_class,
  C.standard_concept Agent_Standard_Concept,
  C.vocabulary_id Agent_Concept_Vocab_ID,
  V.vocabulary_name Agent_Concept_Vocab_Name
FROM
  concept C,
  vocabulary V
WHERE
  LOWER(C.concept_class_id) in ('pharmaceutical / biologic product','physical object',
                                'special concept','event', 'physical force','substance') AND
  LOWER(C.concept_name) like
'%radiation%'                                  
AND C.vocabulary_id = V.vocabulary_id AND
sysdate                                        
BETWEEN C.valid_start_date AND C.valid_end_date;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  Agent_Concept_ID |  Concept ID of SNOMED-CT agent concept |
|  Agent_Concept_Name |  Name of SNOMED-CT concept |
|  Agent_Concept_Code |  Concept Code of SNOMED-CT concept |
|  Agent_Concept_Class |  Concept class of SNOMED-CT concept |
|  Agent_Standard_Concept |  Indicator of standard concept for SNOMED-CT concept |
|  Agent_Vocab_ID |  Vocabulary ID of the vocabulary from which the agent concept is derived from (1 for SNOMED-CT) |
|  Agent_Vocab_Name |  Name of the vocabulary from which the agent concept is derived from (SNOMED-CT) |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Agent_Concept_ID |  4220084 |
|  Agent_Concept_Name |  Radiation |
|  Agent_Concept_Code |  82107009 |
|  Agent_Concept_Class |  Physical force |
|  Agent_Standard_Concept |  S |
|  Agent_Vocab_ID |  SNOMED |
|  Agent_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
