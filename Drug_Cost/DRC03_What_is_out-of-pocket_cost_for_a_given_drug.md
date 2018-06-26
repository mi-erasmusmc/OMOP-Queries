DRC03: What is out-of-pocket cost for a given drug?

Sample query:


```sql
SELECT
  avg(c.paid_by_patient - c.paid_patient_copay) AS avg_out_pocket_cost,
  d.drug_concept_id
FROM cost AS c
  JOIN drug_exposure AS d ON d.drug_exposure_id = c.cost_event_id
WHERE
  (c.paid_by_patient - c.paid_patient_copay) > 0
  AND d.drug_concept_id IN (906805, 1517070, 19010522) -- PARAMETER
GROUP BY d.drug_concept_id
;
```
Input:

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| list of drug_concept_id | 906805, 1517070, 19010522 | Yes |   |

Output:

|  Field |  Description |
| --- | --- |
| drug_concept_id | A foreign key that refers to a standard concept identifier in the vocabulary for the drug concept. |
| total_out_of_pocket | The total amount paid by the person as a share of the expenses, excluding the copay. |
| avg_out_pocket_cost | The average amount paid by the person as a share of the expenses, excluding the copay. |

Sample output record:

|   |
| --- |
| Field |  Description |
| avg_out_pocket_cost |   |
| drug_concept_id |   |
| total_out_of_pocket |   |

