# G07: Find concepts that have a relationship with a given concept

## Description
For a concept identifier entered as the input parameter, the query lists all existing relationships with other concepts. The resulting output includes:

- Type of relationship (including both relationship ID and description)
- Details of the other concept to which the relationship has been defined
- Polarity of the relationship

o    Polarity of "Relates to" implies the input concept is the first concept or CONCEPT_ID_1 of the relationship

o    Polarity of "Is Related by" implies the input concept is the second concept or CONCEPT_ID_2 of the relationship

In vocabulary Version 4.0 and above all relationships are bi-directional, ie. all relationships are repeated as a mirrored version, where CONCEPT_ID_1 and CONCEPT_ID_2 are swapped and the inverse relationship ID is provided.

## Query
```sql
SELECT 'Relates to' relationship_polarity, CR.relationship_ID, RT.relationship_name, D.concept_Id concept_id, D.concept_Name concept_name, D.concept_Code concept_code, D.concept_class_id concept_class_id, D.vocabulary_id concept_vocab_ID, VS.vocabulary_name concept_vocab_name
FROM concept_relationship CR, concept A, concept D, vocabulary VA, vocabulary VS, relationship RT
WHERE CR.concept_id_1 = A.concept_id
AND A.vocabulary_id = VA.vocabulary_id
AND CR.concept_id_2 = D.concept_id
AND D.vocabulary_id = VS.vocabulary_id
AND CR.relationship_id = RT.relationship_ID
AND A.concept_id = 192671
AND sysdate BETWEEN CR.valid_start_date
AND CR.valid_end_date
UNION ALL SELECT 'Is related by' relationship_polarity, CR.relationship_ID, RT.relationship_name, A.concept_Id concept_id, A.concept_name concept_name, A.concept_code concept_code, A.concept_class_id concept_class_id, A.vocabulary_id concept_vocab_ID, VA.Vocabulary_Name concept_vocab_name
FROM concept_relationship CR, concept A, concept D, vocabulary VA, vocabulary VS, relationship RT
WHERE CR.concept_id_1 = A.concept_id
AND A.vocabulary_id = VA.vocabulary_id
AND CR.concept_id_2 = D.concept_id
AND D.vocabulary_id = VS.vocabulary_id
AND CR.relationship_id = RT.relationship_ID
AND D.concept_id = 192671
AND sysdate BETWEEN CR.valid_start_date
AND CR.valid_end_date;
```

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Concept ID |  192671 |  Yes | GI - Gastrointestinal hemorrhage |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | --- |
|  Relationship_Polarity |  Polarity of the relationship with the input concept as a reference:
- "Relates to": Indicates input concept is CONCEPT_ID_1 or the first concept of the relationship
- "Is Related by": Indicates input concept
 |
|  Relationship_ID |  Identifier for the type of relationship |
|  Relationship_Name |  Name of the type of relationship |
|  Concept_ID |  Unique identifier of the concept related to the input concept |
|  Concept_Name |  Name of the concept related to the input concept |
|  Concept_Code |  Concept code of concept related to the input concept |
|  Concept_Class |  Concept Class of concept related to the input concept |
|  Concept_Vocab_ID |  ID of the vocabulary the related concept is derived from |
|  Concept_Vocab_Name |  Name of the vocabulary the related concept is derived from |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Relationship_Polarity |  Is Related to |
|  Relationship_ID |  125 |
|  Relationship_Name |  MedDRA to SNOMED-CT equivalent (OMOP) |
|  Concept_ID |  35707864 |
|  Concept_Name |  Gastrointestinal haemorrhage |
|  Concept_Code |  10017955 |
|  Concept_Class |  Preferred Term |
|  Concept_Vocab_ID |  15 |
|  Concept_Vocab_Name |  MedDRA |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
