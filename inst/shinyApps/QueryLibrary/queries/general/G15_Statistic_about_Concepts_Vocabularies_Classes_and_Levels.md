# G15: Statistic about Concepts, Vocabularies, Classes and Levels

## Description
This query generates the list of all vocabularies in the CONCEPT table (Standard and non-standard), their class, level and frequency.

## Query
```sql
SELECT
  voc.vocabulary_id,
  r.vocabulary_name,
  voc.concept_class_id,
  voc.standard_concept,
  voc.cnt
FROM (
  SELECT
    vocabulary_id,
    concept_class_id,
    standard_concept,
    COUNT(concept_id) cnt
  FROM concept
  GROUP BY
    vocabulary_id,
    concept_class_id,
    standard_concept ) voc
JOIN vocabulary r ON voc.vocabulary_id=r.vocabulary_ID
ORDER BY 1,2,4,3;
```

## Input

None

## Output

| Field |  Description |
| --- | --- |
|  vocabulary_id |  OMOP Vocabulary ID |
|  vocabulary_name |  Vocabulary name |
|  concept_class |  Concept Class |
|  concept_level |  Concept Level Number |
|  cnt |  Number of concepts |

## Sample output record

|  Field |  Value |
| --- | --- |
|  vocabulary_id |  1 |
|  vocabulary_name |  SNOMED-CT |
|  concept_class |  Procedure |
|  concept_level |  2 |
|  cnt |  20286 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
