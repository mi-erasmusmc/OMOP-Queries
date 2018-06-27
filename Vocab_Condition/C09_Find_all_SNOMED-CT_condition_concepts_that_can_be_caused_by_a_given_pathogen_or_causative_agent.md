# C09: Find all SNOMED-CT condition concepts that can be caused by a given pathogen or causative agent

This query accepts a SNOMED-CT pathogen ID as input and returns all conditions caused by the pathogen or disease causing agent identified using queries  [C07](http://vocabqueries.omop.org/condition-queries/c7) or  [C08](http://vocabqueries.omop.org/condition-queries/c8).

## Sample query

The following is a sample run of the query to list conditions caused by pathogen or causative agent. Sample parameter substitution is highlighted in  blue.

```sql
SELECT
  a.concept_id       AS condition_id,
  a.concept_name     AS condition_name,
  a.concept_code     AS condition_code,
  a.concept_class_id AS condition_class,
  a.vocabulary_id    AS condition_vocab_id,
  d.concept_id       AS causative_agent_id,
  d.concept_name     AS causative_agent_name,
  d.concept_code     AS causative_agent_code,
  d.concept_class_id AS causative_agent_class,
  d.vocabulary_id    AS causative_agent_vocab_id
FROM concept_relationship AS cr
  JOIN concept AS a ON cr.concept_id_1 = a.concept_id
  JOIN concept AS d ON cr.concept_id_2 = d.concept_id
WHERE
  cr.relationship_id = 'Has causative agent' AND
  d.concept_id = 4248851 AND -- PARAMETER
  sysdate BETWEEN cr.valid_start_date AND cr.valid_end_date -- PARAMETER
;
```

### Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  SNOMED-CT Concept ID |  4248851 |  Yes | Concept Identifier for 'Treponema pallidum' |
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
|  Causative_Agent_ID |  Pathogen concept ID entered as input |
|  Causative_Agent_Name |  Pathogen Name |
|  Causative_Agent_Code |  Concept Code of pathogen concept |
|  Causative_Agent_Class |  Concept Class of pathogen concept |
|  Causative_Agent_Vocab_ID |  Vocabulary the pathogen concept is derived from as vocabulary ID |

#### Sample output record

|  Field |  Value |
| --- | --- |
|  Condition_ID |  4326735 |
|  Condition_Name |  Spastic spinal syphilitic paralysis |
|  Condition_Code |  75299005 |
|  Condition_Class |  Clinical finding |
|  Condition_Vocab_ID |  SNOMED |
|  Causative_Agent_ID |  4248851 |
|  Causative_Agent_Name |  Treponema pallidum |
|  Causative_Agent_Code |  72904005 |
|  Causative_Agent_Class |  Organism |
|  Causative_Agent_Vocab_ID |  SNOMED |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT_RELATIONSHIP
