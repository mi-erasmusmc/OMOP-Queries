# C09: Find all SNOMED-CT condition concepts that can be caused by a given pathogen or causative agent

## Description
This query accepts a SNOMED-CT pathogen ID as input and returns all conditions caused by the pathogen or disease causing agent identified using queries  [C07](http://vocabqueries.omop.org/condition-queries/c7) or  [C08](http://vocabqueries.omop.org/condition-queries/c8).

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  SNOMED-CT Concept ID |  4248851 |  Yes | Concept Identifier for 'Treponema pallidum' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Query
The following is a sample run of the query to list conditions caused by pathogen or causative agent. Sample parameter substitution is highlighted in  blue.

```sql
SELECT 
  A.concept_Id Condition_ID, 
  A.concept_Name Condition_name, 
  A.concept_Code Condition_code, 
  A.concept_Class_id Condition_class, 
  A.vocabulary_id Condition_vocab_ID, 
  VA.vocabulary_name Condition_vocab_name, 
  D.concept_Id Causative_agent_ID, 
  D.concept_Name Causative_agent_Name, 
  D.concept_Code Causative_agent_Code, 
  D.concept_Class_id Causative_agent_Class, 
  D.vocabulary_id Causative_agent_vocab_ID, 
  VS.vocabulary_name Causative_agent_vocab_name 
FROM 
  concept_relationship CR, 
  concept A, 
  concept D, 
  vocabulary VA, 
  vocabulary VS
WHERE 
  CR.relationship_ID = 'Has causative agent' AND 
  CR.concept_id_1 = A.concept_id AND 
  A.vocabulary_id = VA.vocabulary_id AND 
  CR.concept_id_2 = D.concept_id AND 
  D.concept_id =
4248851                                             
  AND D.vocabulary_id = VS.vocabulary_id AND 
sysdate                                             
  BETWEEN CR.valid_start_date AND CR.valid_end_date;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
|  Condition_ID |  Condition concept Identifier |
|  Condition_Name |  Name of the standard condition concept |
|  Condition_Code |  Concept code of the standard concept in the source vocabulary |
|  Condition_Class |  Concept class of standard vocabulary concept |
|  Condition_Vocab_ID |  Vocabulary the standard concept is derived from as vocabulary ID |
|  Condition_Vocab_Name |  Name of the vocabulary the standard concept is derived from |
|  Causative_Agent_ID |  Pathogen concept ID entered as input |
|  Causative_Agent_Name |  Pathogen Name |
|  Causative_Agent_Code |  Concept Code of pathogen concept |
|  Causative_Agent_Class |  Concept Class of pathogen concept |
|  Causative_Agent_Vocab_ID |  Vocabulary the pathogen concept is derived from as vocabulary ID |
|  Causative_Agent_Vocab_Name |  Name of the vocabulary the pathogen concept is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Condition_ID |  4326735 |
|  Condition_Name |  Spastic spinal syphilitic paralysis |
|  Condition_Code |  75299005 |
|  Condition_Class |  Clinical finding |
|  Condition_Vocab_ID |  SNOMED |
|  Condition_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |
|  Causative_Agent_ID |  4248851 |
|  Causative_Agent_Name |  Treponema pallidum |
|  Causative_Agent_Code |  72904005 |
|  Causative_Agent_Class |  Organism |
|  Causative_Agent_Vocab_ID |  SNOMED |
|  Causative_Agent_Vocab_Name |  Systematic Nomenclature of Medicine - Clinical Terms (IHTSDO) |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
