CS01: Care site place of service counts
---
This query is used to count the care sites associated with the place of service type. This query is only available from CDM V4 and above.

Sample query:

```sql
SELECT
  cs.place_of_service_concept_id,
  count(*) AS places_of_service_count
FROM care_site AS cs
GROUP BY cs.place_of_service_concept_id
ORDER BY cs.place_of_service_concept_id
;
```

Input:

None

Output:

| Field |  Description |
| --- | --- |
| place_of_service_concept_id | A foreign key that refers to a place of service concept identifier in the vocabulary. |
| places_of_service_count |   |

Sample output record:

| Field |  Description |
| --- | --- |
| place_of_service_concept_id |  8546 |
| places_of_service_count |  1 |
