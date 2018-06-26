C08: Find a disease causing agent by keyword
---
This query enables a search of various agents that can cause disease by keyword as input. Apart from pathogens (see query  [C07](http://vocabqueries.omop.org/condition-queries/c7)), these agents can be SNOMED-CT concepts of the following classes:
- Pharmaceutical / biologic product
- Physical object
- Special concept
- Event
- Physical force
- Substance

The resulting concepts could be used in query  [C09](http://vocabqueries.omop.org/condition-queries/c9) to identify diseases caused by the agent.

Input:

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Keyword for pathogen |  'Radiation' |  Yes | Keyword should be placed in a single quote |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

Sample query run:

The following is a sample run of the query to list all pathogens specified using a keyword as input. The sample parameter substitutions are highlighted in  blue.

```sql
SELECT
  c.concept_id       AS agent_concept_id,
  c.concept_name     AS agent_concept_name,
  c.concept_code     AS agent_concept_code,
  c.concept_class_id AS agent_concept_class,
  c.standard_concept AS agent_standard_concept,
  c.vocabulary_id    AS agent_concept_vocab_id
FROM concept AS c
WHERE
  lower(c.concept_class_id) IN ('pharmaceutical / biologic product', 'physical object',
                                'special concept', 'event', 'physical force', 'substance') AND
  lower(c.concept_name) LIKE '%radiation%' AND -- PARAMETER
  sysdate BETWEEN c.valid_start_date AND c.valid_end_date -- PARAMETER
;
```

Output:

Output field list:

|  Field |  Description |
| --- | --- |
|  Agent_Concept_ID |  Concept ID of SNOMED-CT agent concept |
|  Agent_Concept_Name |  Name of SNOMED-CT concept |
|  Agent_Concept_Code |  Concept Code of SNOMED-CT concept |
|  Agent_Concept_Class |  Concept class of SNOMED-CT concept |
|  Agent_Standard_Concept |  Indicator of standard concept for SNOMED-CT concept |
|  Agent_Vocab_ID |  Vocabulary ID of the vocabulary from which the agent concept is derived from (1 for SNOMED-CT) |
|  Agent_Vocab_Name |  Name of the vocabulary from which the agent concept is derived from (SNOMED-CT) |

Sample output record:

|  Field |  Value |
| --- | --- |
|  Agent_Concept_ID |  4220084 |
|  Agent_Concept_Name |  Radiation |
|  Agent_Concept_Code |  82107009 |
|  Agent_Concept_Class |  Physical force |
|  Agent_Standard_Concept |  S |
|  Agent_Vocab_ID |  SNOMED |
|  Agent_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
