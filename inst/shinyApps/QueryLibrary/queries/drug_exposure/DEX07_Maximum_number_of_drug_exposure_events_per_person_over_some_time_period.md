# DEX07: Maximum number of drug exposure events per person over some time period

## Description
| This query is to determine the maximum number of drug exposures that is recorded for a patient during a certain time period. If the time period is omitted, the entire time span of the database is considered. Instead of maximum, the query can be easily changed to obtained the average or the median number of drug records for all patients. See  [vocabulary queries](http://vocabqueries.omop.org/drug-queries) for obtaining valid drug_concept_id values.

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| date from | 01-Jan-2008 | Yes | | 
| date to | 31-Dec-2008 | Yes |   | 

## Query
The following is a sample run of the query. The input parameters are highlighted in  blue. 

```sql
select max(exposures ) as exposures_count from 
(SELECT 
drug_exposure.person_id, COUNT(*) exposures 
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
| exposures_count | The number of drug exposure records for the patient with the maximum number of such records. |


## Sample output record

|  Field |  Description |
| --- | --- | 
| exposures_count | 1137 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
