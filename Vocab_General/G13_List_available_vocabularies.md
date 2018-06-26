G13: List available vocabularies
---

This query returns list of available vocabularies.

Sample query:


```sql
SELECT
  vocabulary_id,
  vocabulary_name
FROM vocabulary
;
```
Input:

None

Output:

| Field |  Description |
| --- | --- |
|  vocabulary_id |  OMOP Vocabulary ID |
|  vocabulary_name |  Vocabulary name |

Sample output record:

| Field |  Value |
| --- | --- |
|  vocabulary_id |  1 |
|  vocabulary_name |  SNOMED-CT |

