# DER11: Distribution of drug era start dates

## Description
This query is used to to provide summary statistics for drug era start dates (drug_era_start_date) across all drug era records: the mean, the standard deviation, the minimum, the 25th percentile, the median, the 75th percentile, the maximum and the number of missing values. No input is required for this query.

## Query
```sql
SELECT distinct min(tt.start_date) over () AS min_date , max(tt.start_date) over () AS max_date ,
avg(tt.start_date_num) over () + tt.min_date AS avg_date , (round(stdDev(tt.start_date_num) over ())) AS stdDev_days ,
tt.min_date +
(PERCENTILE_DISC(0.25) WITHIN GROUP( ORDER BY tt.start_date_num ) over ()) AS percentile_25_date
, tt.min_date + (PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY tt.start_date_num ) over() ) AS median_date
, tt.min_date + (PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY tt.start_date_num ) over() ) AS percential_75_date
FROM (
SELECT (t.drug_era_start_date - MIN(t.drug_era_start_date) OVER()) AS start_date_num, t.drug_era_start_date AS start_date, MIN(t.drug_era_start_date) OVER() min_date
FROM drug_era t ) tt
GROUP BY tt.start_date, tt.start_date_num, tt.min_date;
```

## Input

None

## Output

|  Field |  Description |
| --- | --- | 
| Min_date | Minimum drug era start date across all drug era records |
| Max_date | Maximum drug era start date across all drug era records |
| Avg_date | Average drug era start date across all drug era records |
| Stddev_days | Standard deviation of drug era start date across all drug era records |
| percentile_25_date | 25th percentile of the drug era start date |
| median_date | Median of the drug era start date |
| percentile_75_date | the 75th percentile of the drug era start date |

## Sample output record

|  Field |  Description |
| --- | --- |
| Min_date | 1997-01-01 00:00:00 |
| Max_date | 2017-12-31 00:00:00 |
| Avg_date | 2007-07-02 00:00:00 |
| Stddev_days | 2214 |
| percentile_25_date | 2002-04-02 00:00:00 |
| median_date | 2007-07-02 00:00:00 |
| percentile_75_date | 2012-10-01 00:00:00 |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
