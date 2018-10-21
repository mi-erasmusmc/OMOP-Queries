# DER04: What proportion of observation time is a person exposed to a given drug?

## Description
## Query
```sql
SELECT        decode(o.totalObs, 0, 0, 100*(e.totExposure*1.0/o.totalObs*1.0)) as proportion
FROM
        (
        SELECT        SUM(r.drug_era_end_date - r.drug_era_start_date) AS totExposure,
                        r.person_id
        FROM        drug_era r
        WHERE
                r.person_id                 = 9717995
        AND        r.drug_concept_id         = 1549080
        group by        r.person_id
        ) e,
        (
        SELECT        sum(p.observation_period_end_date - p.observation_period_start_date) AS totalObs,
                        p.person_id FROM observation_period p
        group by p.person_id
        ) o
where
        o.person_id = e.person_id
```

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| drug_concept_id | 1549080 | Yes | Estrogens, Conjugated (USP) |

## Output

|  Field |  Description |
| --- | --- |
| proportion | proportion of observation time is a person exposed to a given drug |

## Sample output record

|  Field |  Value |
| --- | --- |
| proportion |  0.1 |



## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
