# PE06: Number of patients grouped by year of birth

Counts the year of birth (year_of_birth) across all person records. All existing values for year of birth are summarized.

## Sample query
```sql
SELECT year_of_birth, COUNT(person_id) AS Num_Persons_count
FROM person
GROUP BY year_of_birth
ORDER BY year_of_birth;
```

### Input

None

### Output

|  Field |  Description |
| --- | --- |
|  year_of_birth |  Year of birth of the patient |
|  Num_Persons_count |  Number of patients in the dataset of specific year of birth |

### Sample output record

| Field |  Value |
| --- | --- |
|  year_of_birth |  1950 |
|  Num_Persons_count |  389019 |


## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
