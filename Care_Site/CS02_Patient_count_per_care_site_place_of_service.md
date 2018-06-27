# CS02: Patient count per care site place of service.

This query is used to count patients per care site place of service. This query is only available from CDM V4 and above.

## Sample query

```sql
SELECT
  cs.place_of_service_concept_id,
  count(*) AS num_patients
FROM care_site AS cs
  JOIN person AS p ON p.care_site_id = cs.care_site_id
GROUP BY cs.place_of_service_concept_id
ORDER BY cs.place_of_service_concept_id
;
```
### Input

None

### Output

|  Field |  Description |
| --- | --- |
| place_of_service_concept_id | A foreign key that refers to a place of service concept identifier in the vocabulary. |
| care_site_id | A foreign key to the main care site where the provider is practicing. |
| num_patients |   |

### Sample output record

|  Field |  Description |
| --- | --- |
| place_of_service_concept_id | 8546  |
| num_patients | 555  |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CARE_SITE
