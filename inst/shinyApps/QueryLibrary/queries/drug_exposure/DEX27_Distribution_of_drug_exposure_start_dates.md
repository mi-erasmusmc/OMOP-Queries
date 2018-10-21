# DEX27: Distribution of drug exposure start dates

## Description
| This query is used to to provide summary statistics for drug exposure start dates (drug_exposure_start_date) across all drug exposure records: the mean, the standard deviation, the minimum, the 25th percentile, the median, the 75th percentile, the maximum and the number of missing values. No input is required for this query.

## Input <None>
## Query
The following is a sample run of the query.  

```sql
SELECT
    min(tt.start_date) AS min_date , 
    max(tt.start_date) AS max_date , 
    avg(tt.start_date_num) + tt.min_date AS avg_date , 
    (round(stdDev(tt.start_date_num)) ) AS stdDev_days , 
    tt.min_date + (approximate PERCENTILE_DISC(0.25) WITHIN GROUP( ORDER BY tt.start_date_num ) ) AS percentile_25_date , 
    tt.min_date + (approximate PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY tt.start_date_num ) ) AS median_date , 
    tt.min_date + (approximate PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY tt.start_date_num ) ) AS percentile_75_date 
FROM ( 
    SELECT
        (t.drug_exposure_start_date - MIN(t.drug_exposure_start_date) OVER()) AS start_date_num, 
        t.drug_exposure_start_date AS start_date, 
        MIN(t.drug_exposure_start_date) OVER() min_date 
    FROM drug_exposure t 
    ) tt 
GROUP BY tt.min_date ; 
```

## Output

## Output field list

|  Field |  Description |
| --- | --- | 
| min_value |   |
| max_value |   |
| avg_value |   |
| stdDev_value |   |
| percentile_25 |   |
| median_value |   |
| percentile_75 |   |

## Sample output record

|  Field |  Description |
| --- | --- | 
| min_value |   |
| max_value |   |
| avg_value |   |
| stdDev_value |   |
| percentile_25 |   |
| median_value |   |
| percentile_75 |   |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
