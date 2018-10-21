# G16: Statistics about Condition Mapping of Source Vocabularies

## Description
The following query contains the coverage for mapped source vocabularies in the Condition domains to SNOMED-CT.

## Query
```sql
SELECT
  mapped.vocabulary_id,
  mapped.vocabulary_name,
  CASE mapped.standard_concept
    WHEN null THEN 'Not mapped'
        ELSE mapped.standard_concept
  END AS standard_concept,
  mapped.mapped_codes,
  sum(mapped.mapped_codes) over (partition by vocabulary_id) as total_mapped_codes,
  to_char(mapped.mapped_codes*100/sum(mapped.mapped_codes) over (partition by vocabulary_id), '990.9') AS pct_mapped_codes,
  mapped.mapped_concepts,
  (SELECT count(1)
   FROM concept
   WHERE
     vocabulary_id='SNOMED' AND
        standard_concept=mapped.standard_concept AND
        lower(concept_class_id)='clinical finding' AND
        invalid_reason is null
  ) AS standard_concepts,
  to_char(mapped.mapped_concepts*100/
         ( SELECT CASE count(1) WHEN 0 THEN 1e16 ELSE count(1) END
                  FROM concept
                  WHERE
                    vocabulary_id='SNOMED' AND
                        standard_concept=mapped.standard_concept AND
                        lower(concept_class_id)='clinical finding' AND
                        invalid_reason is null ), '990.9'
  ) AS pct_mapped_concepts
FROM (
  SELECT
    c1.vocabulary_id AS vocabulary_id,
        v.vocabulary_name,
        c2.standard_concept,
        COUNT(8) AS mapped_codes,
        COUNT(DISTINCT c2.concept_id) AS mapped_concepts
  FROM concept_relationship m
  JOIN concept c1 on m.concept_id_1=c1.concept_id and
       m.relationship_id='Maps to' and m.invalid_reason is null
  JOIN concept c2 on c2.concept_id=m.concept_id_2
  JOIN vocabulary v on v.vocabulary_id=c1.vocabulary_id
  WHERE c2.vocabulary_id='SNOMED' AND lower(c2.domain_id)='condition'
  GROUP BY c1.vocabulary_id, v.vocabulary_name, c2.standard_concept
) mapped;
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
|  vocabulary_id |  Source Vocabulary ID |
|  vocabulary_name |  Source Vocabulary name |
|  concept_level |  Concept Level Number |
|  mapped_codes |  Number of mapped codes |
|  total_mapped_codes |  Total number of mapped codes for source vocabulary |
|  pct_mapped_codes |  Percentile of mapped code  |
|  mapped_concepts |  Number of mapped concepts  |
|  concepts_in_level |  Number of mapped concepts  |
|  pct_mapped_concepts |  Percentile of of mapped concepts |

## Sample output record

| Field |  Value |
| --- | --- |
|  vocabulary_id |  2 |
|  vocabulary_name |  ICD9-CT |
|  concept_level |  1 |
|  mapped_codes |  4079 |
|  total_mapped_codes |  10770 |
|  pct_mapped_codes |  37.0 |
|  mapped_concepts |  3733 |
|  concepts_in_level |  69280 |
|  pct_mapped_concepts |  5.0 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
