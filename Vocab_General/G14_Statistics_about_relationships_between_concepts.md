# G14: Statistics about relationships between concepts

This query produces list and frequency of all relationships between concepts (Standard and non-standard) and their class

## Sample query

```sql
SELECT
  cr.relationship_id  AS relationship_id,
  c1.vocabulary_id    AS from_vocabulary_id,
  c1.concept_class_id AS from_concept_class,
  c2.vocabulary_id    AS to_vocabulary_id,
  c2.concept_class_id AS to_concept_class,
  count(*)            AS num_records
FROM concept_relationship AS cr
  JOIN concept AS c1 ON cr.concept_id_1 = c1.concept_id
  JOIN concept AS c2 ON cr.concept_id_2 = c2.concept_id
GROUP BY
  cr.relationship_id,
  c1.vocabulary_id,
  c1.concept_class_id,
  c2.vocabulary_id,
  c2.concept_class_id
ORDER BY
  cr.relationship_id,
  c1.concept_class_id
;
```
### Input

None

### Output

|  Field |  Description |
| --- | --- |
|  relationship_id |  Identifier for the type of relationship |
|  from_vocabulary_id |  ID of the vocabulary of the input concepts |
|  from_concept_class |  Concept class of the input concepts |
|  to_vocabulary_id |  ID of the vocabulary the related concept is derived from |
|  to_concept_class |  Concept class the related concept is derived from |
|  num_records |  Number of records  |

### Sample output record

|  Field |  Value |
| --- | --- |
|  relationship_id |  Concept replaced by (LOINC) |
|  from_vocabulary_id |  LOINC |
|  from_concept_class |  LOINC Code |
|  to_vocabulary_id |  LOINC |
|  to_concept_class |  LOINC Code |
|  num_records |  2022 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT_RELATIONSHIP
