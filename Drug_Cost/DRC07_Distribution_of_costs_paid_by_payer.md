DRC07:Distribution of costs paid by payer.
---

This query is used to to provide summary statistics for costs paid by coinsurance (paid_coinsurance) across all drug cost records: the mean, the standard deviation, the minimum, the 25th percentile, the median, the 75th percentile, the maximum and the number of missing values. No input is required for this query.

Sample query:


```sql
WITH tt AS (
    SELECT paid_patient_coinsurance AS stat_value
    FROM cost
    WHERE paid_patient_coinsurance > 0
)
SELECT
  min(tt.stat_value)             AS min_value,
  max(tt.stat_value)             AS max_value,
  avg(tt.stat_value)             AS avg_value,
  (round(stdDev(tt.stat_value))) AS stddev_value,
  (SELECT DISTINCT PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY tt.stat_value) OVER () FROM tt) AS percentile_25,
  (SELECT DISTINCT PERCENTILE_DISC(0.50) WITHIN GROUP (ORDER BY tt.stat_value) OVER () FROM tt) AS median_value,
  (SELECT DISTINCT PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY tt.stat_value) OVER () FROM tt) AS percential_75
FROM tt
;
```
Input:

None

Output:

|   |
| --- |
|  Field |  Description |
| min_value | The portion of the drug expenses due to the cost charged by the manufacturer for the drug, typically a percentage of the Average Wholesale Price. |
| max_value |   |
| avg_value |   |
| stdDev_value |   |

Sample output record:

|  Field |  Description |
| --- | --- |
| min_value |   |
| max_value |   |
| avg_value |   |
| stdDev_value |   |



