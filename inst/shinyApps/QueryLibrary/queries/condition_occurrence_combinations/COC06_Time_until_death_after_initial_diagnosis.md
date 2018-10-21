# COC06: Time until death after initial diagnosis

## Description
## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| concept_name | OMOP Acute Myocardial Infarction 1 | Yes |   |

## Query
The following is a sample run of the query. The input parameters are highlighted in  blue  

```sql
SELECT COUNT( DISTINCT diagnosed.person_id ) AS all_infarction_deaths
     , ROUND( min( death_date - condition_era_start_date )/365, 1 ) AS min_years
     , ROUND( max( death_date - condition_era_start_date )/365, 1 ) AS max_years
     , ROUND( avg( death_date - condition_era_start_date )/365, 1 ) AS avg_years
  FROM -- Initial diagnosis of Acute Myocardial Infarction
     ( SELECT DISTINCT person_id, condition_era_start_date
         FROM  /* diagnosis of Acute Myocardial Infarction, ranked by
                  date, 6 month clean
                */
            ( SELECT condition.person_id, condition.condition_era_start_date
                   , rank() OVER( PARTITION BY condition.person_id
                                      ORDER BY condition_era_start_date
                                ) AS ranking
                FROM condition_era condition
                JOIN -- definition of Acute Myocardial Infarction 1
                   ( SELECT DISTINCT descendant_concept_id
                       FROM relationship
                       JOIN concept_relationship rel USING( relationship_id ) 
                       JOIN concept concept1 ON concept1.concept_id = concept_id_1
                       JOIN concept_ancestor ON ancestor_concept_id = concept_id_2
                      WHERE relationship_name = 'HOI contains SNOMED (OMOP)'
                        AND concept1.concept_name = 'OMOP Acute Myocardial Infarction 1'
                        AND sysdate BETWEEN rel.valid_start_date and rel.valid_end_date
                   ) ON descendant_concept_id = condition_concept_id
                JOIN observation_period obs
                  ON obs.person_id = condition.person_id
                 AND condition_era_start_date >= observation_period_start_date + 180
            )
        WHERE ranking = 1
     ) diagnosed
  JOIN death 
    ON death.person_id = diagnosed.person_id
```

## Output

## Output field list

|  Field |  Description |
| --- | --- |
| all_infarction_deaths |   |
| min_years |   |
| max_years |   |
| avg_years |   |

## Sample output record

|  Field |  Description |
| --- | --- |
| all_infarction_deaths |   |
| min_years |   |
| max_years |   |
| avg_years |   |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
