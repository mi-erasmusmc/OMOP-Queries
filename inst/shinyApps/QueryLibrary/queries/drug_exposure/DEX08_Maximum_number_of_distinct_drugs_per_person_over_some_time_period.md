# DEX08: Maximum number of distinct drugs per person over some time period

## Description
| This query is to determine the maximum number of distinct drugs a patient is exposed to during a certain time period. If the time period is omitted, the entire time span of the database is considered. See  [vocabulary queries](http://vocabqueries.omop.org/drug-queries) for obtaining valid drug_concept_id values.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| date from | 01-Jan-2008 | Yes |   |
| date to | 31-Dec-2008 | Yes |   | 

## Query
The following is a sample run of the query. The input parameters are highlighted in  blue. s

```sql
select max(drugs) as drugs_count from 
(SELECT 
COUNT( DISTINCT drug_concept_id) drugs 
FROM drug_exposure JOIN person
ON drug_exposure.person_id = person.person_id
WHERE 
drug_concept_id in (select distinct concept_id from concept 
                        WHERE lower(domain_id)='drug' and vocabulary_id='RxNorm' and standard_concept='S')
AND drug_exposure_start_date BETWEEN '2017-01-01' AND '2017-12-31' 
GROUP BY drug_exposure.person_id);
```

## Output

## Output field list

|  Field |  Description |
| --- | --- | 
| drugs_count | The maximum number of distinct drugs a patient is exposed to during the time period |

## Sample output record

|  Field |  Content |
| --- | --- | 
| drugs_count | 141 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
