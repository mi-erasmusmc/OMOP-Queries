# G14: Statistics about relationships between concepts

## Description
This query produces list and frequency of all relationships between concepts (Standard and non-standard) and their class

## Query
```sql
SELECT
  R.relationship_id,
  R.relationship_name,
  C1.vocabulary_id from_vocabulary_id,
  V1.vocabulary_name from_vocabulary_name,
  C1.concept_class_id from_concept_class,
  C2.vocabulary_id to_vocabulary_id,
  V2.vocabulary_name to_vocabulary_name,
  C2.concept_class_id to_concept_class,
  count(*) num_records
FROM
  concept_relationship CR,
  concept C1,
  concept C2,
  relationship R,
  vocabulary V1,
  vocabulary V2
WHERE
  CR.concept_id_1 = C1.concept_id AND
  CR.concept_id_2 = C2.concept_id AND
  R.relationship_id = CR.relationship_id AND
  C1.vocabulary_id = V1.vocabulary_id AND
  C2.vocabulary_id = V2.vocabulary_id
GROUP BY
  R.relationship_id,
  relationship_name,
  C1.vocabulary_id,
  V1.vocabulary_name,
  C1.concept_class_id,
  C2.vocabulary_id,
  V2.vocabulary_name,
  C2.concept_class_id
ORDER BY
  R.relationship_id,
  C1.concept_class_id;
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
|  relationship_id |  Identifier for the type of relationship |
|  relationship_name |  Name of the type of relationship |
|  from_vocabulary_id |  ID of the vocabulary of the input concepts |
|  from_vocabulary_name |  Name of the vocabulary of the input concepts |
|  from_concept_class |  Concept class of the input concepts |
|  to_vocabulary_id |  ID of the vocabulary the related concept is derived from |
|  to_vocabulary_name |  Name of the vocabulary the related concept is derived from |
|  to_concept_class |  Concept class the related concept is derived from |
|  num_records |  Number of records  |

## Sample output record

|  Field |  Value |
| --- | --- |
|  relationship_id |  1 |
|  relationship_name |  Concept replaced by (LOINC) |
|  from_vocabulary_id |  6 |
|  from_vocabulary_name |  LOINC |
|  from_concept_class |  LOINC Code |
|  to_vocabulary_id |  6 |
|  to_vocabulary_name |  LOINC |
|  to_concept_class |  LOINC Code |
|  num_records |  2022 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
