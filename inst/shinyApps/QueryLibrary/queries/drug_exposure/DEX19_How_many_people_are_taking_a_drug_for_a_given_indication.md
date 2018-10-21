# DEX19: How many people are taking a drug for a given indication?

## Description
## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
| concept_name | Acute Tuberculosis | Yes | 

## Query
The following is a sample run of the query. The input parameters are highlighted in 

```sql
SELECT concept_name, count( distinct person_id ) 
 FROM drug_exposure JOIN /* indication and associated drug ids */
     (select indication.concept_name, drug.concept_id
        from concept indication 
        JOIN concept_ancestor ON ancestor_concept_id = indication.concept_id 
        JOIN vocabulary indication_vocab ON indication_vocab.vocabulary_id = indication.vocabulary_id
        JOIN concept drug ON drug.concept_id = descendant_concept_id 
        JOIN vocabulary drug_vocab ON drug_vocab.vocabulary_id = drug.vocabulary_id 
        WHERE sysdate BETWEEN drug.valid_start_date AND drug.valid_end_date
        AND drug_vocab.vocabulary_id = 'RxNorm'
        AND indication.concept_class_id = 'Indication'
        AND indication_vocab.vocabulary_name = 'Indications and Contraindications (FDB)'
        AND indication.concept_name = 'Active Tuberculosis' /*This filter can be changed or omitted if count need for all indication*/
        AND drug.standard_concept='S'
    )
ON concept_id = drug_concept_id GROUP BY concept_name;
```

## Output

## Output field list

|  Field |  Description |
| --- | --- | 
| concept_name | The reason the medication was stopped, where available. Reasons include regimen completed, changed, removed, etc. |
| count |   |


## Sample output record

|  Field |  Description |
| --- | --- | 
| concept_name |   |
| count |   |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
