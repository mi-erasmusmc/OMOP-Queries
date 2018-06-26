PE08: Number of patients grouped by zip code of residence
---

Counts the patients' zip of their residence location across all person records. All possible values for zip are summarized. Zip code contains only the first 3 digits in most databases.

Sample query:


```sql
SELECT
  state,
  zip,
  count(*) AS num_persons_count
FROM person
  LEFT JOIN location USING (location_id)
GROUP BY state, zip
ORDER BY state, zip
;
```
Input:

None

Output:

|  Field |  Description |
| --- | --- |
| State | State of residence |
| Zip | 3 digit zip code of residence |
| Num_Persons_count | Number of patients in the dataset residing in a specific zip code |

Sample output record:

| Field |  Value |
| --- | --- |
| State | MA |
| Zip | 019 |
| Num_Persons_count | 477825 |


