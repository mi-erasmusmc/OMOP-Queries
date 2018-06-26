DRC01: What is the average/max/min cost per pill (total cost / quantity) per drug concept?
---

Sample query:


```sql
SELECT
  t.drug_concept_id,
  avg(t.cost_per_pill) AS avg_val_num,
  max(t.cost_per_pill) AS max_val_num,
  min(t.cost_per_pill) AS min_val_num
FROM (
       SELECT
         c.total_paid / d.quantity AS cost_per_pill,
         d.drug_concept_id
       FROM cost AS c
         JOIN drug_exposure AS d ON d.drug_exposure_id = c.cost_event_id
       WHERE d.quantity > 0
             AND d.drug_concept_id IN (906805, 1517070, 19010522) -- PARAMETER
     ) AS t
GROUP BY t.drug_concept_id
ORDER BY t.drug_concept_id
;
```
Input:

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| list of drug_concept_id | 906805, 1517070, 19010522 | Yes |


Output:

|  Field |  Description |
| --- | --- |
| drug_concept_id | Drug concept id |
| avg_val_num | Average cost per pill |
| max_val_num | Max cost per pill |
| min_val_num | Min cost per pill |



Sample output record:

|  Field |  Description |
| --- | --- |
| drug_concept_id | 19010522 |
| avg_val_num | 2.6983903185925794872997154 |
| max_val_num | 3197.50 |
| min_val_num | 0 |



