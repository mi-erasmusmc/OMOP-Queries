PE07: Number of patients grouped by residence state location
---

This query is used to count the locations (location_id) across all person records. All possible values for location are summarized.

Sample query:


```sql
SELECT
  state    AS state_abbr,
  count(*) AS num_persons_count
FROM person
  LEFT JOIN location USING (location_id)
GROUP BY state
ORDER BY state
;
```
Input:

None

Output:

| Field |  Description |
| --- | --- |
| State | State of residence |
| Num_Persons_count | Number of patients in the dataset residing in specific state |

Sample output record:

| Field |  Value |
| --- | --- |
| State | MA |
| Num_Persons_count | 1196292 |


