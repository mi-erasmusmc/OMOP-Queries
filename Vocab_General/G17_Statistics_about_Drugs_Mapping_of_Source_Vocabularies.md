G17: Statistics about Drugs Mapping of Source Vocabularies
---

The following query contains the coverage for mapped source vocabularies in the Drug domains to RxNorm.

Sample query:


```sql
SELECT
  mapped.vocabulary_id,
  CASE mapped.standard_concept
    WHEN NULL THEN 'Not mapped'
        ELSE mapped.standard_concept
  END AS standard_concept,
  mapped.mapped_codes,
  sum(mapped.mapped_codes) OVER (PARTITION BY vocabulary_id) AS total_mapped_codes,
  to_char(mapped.mapped_codes*100/sum(mapped.mapped_codes) OVER (PARTITION BY vocabulary_id), '990.9') AS pct_mapped_codes,
  mapped.mapped_concepts,
  (SELECT count(*)
   FROM concept
   WHERE vocabulary_id='RxNorm' AND
         standard_concept=mapped.standard_concept AND
         invalid_reason IS NULL
  ) AS standard_concepts,
  to_char(mapped.mapped_concepts*100/
         ( SELECT CASE count(*) WHEN 0 THEN 1e16 ELSE count(*) END
                  FROM concept
                  WHERE vocabulary_id='RxNorm' AND
                        standard_concept=mapped.standard_concept AND
                        invalid_reason IS NULL ), '990.9'
  ) AS pct_mapped_concepts
FROM (
  SELECT
    c1.vocabulary_id AS vocabulary_id,
    c2.standard_concept,
    count(*) AS mapped_codes,
    count(DISTINCT c2.concept_id) AS mapped_concepts
  FROM concept_relationship AS m
  JOIN concept AS c1 ON m.concept_id_1=c1.concept_id AND
       m.relationship_id='Maps to' AND m.invalid_reason IS NULL
  JOIN concept AS c2 ON c2.concept_id=m.concept_id_2
  WHERE c2.vocabulary_id IN ('ICD9CM','RxNorm') AND lower(c2.domain_id)='drug'
  GROUP BY c1.vocabulary_id, c2.standard_concept
) AS mapped;
```
Input:

None

Output:

| Field |  Description |
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

Sample output record:

| Field |  Value |
| --- | --- |
|  vocabulary_id |  9 |
|  vocabulary_name |  NDC |
|  concept_level |  1 |
|  mapped_codes |  550959 |
|  total_mapped_codes |  551757 |
|  pct_mapped_codes |  99.0 |
|  mapped_concepts |  33206 |
|  concepts_in_level |  57162 |
|  pct_mapped_concepts |  58.0 |





