# CS02: Patient count per care site place of service.

## Description
This query is used to count patients per care site place of service. This query is only available from CDM V4 and above.

## Query
```sql
select cs.place_of_service_concept_id, count(1) num_patients
from care_site cs, person p
where p.care_site_id = cs.care_site_id
group by cs.place_of_service_concept_id
order by 1;
```

## Input

None

## Output

|  Field |  Description |
| --- | --- |
| place_of_service_concept_id | A foreign key that refers to a place of service concept identifier in the vocabulary. |
| care_site_id | A foreign key to the main care site where the provider is practicing. |
| num_patients |   |

## Sample output record

|  Field |  Description |
| --- | --- |
| place_of_service_concept_id |   |
| care_site_id |   |
| num_patients |   |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
