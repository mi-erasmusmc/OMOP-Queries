# G01: Find concept by concept ID

This is the most generic look-up for obtaining concept details associated with a concept identifier. The query is intended as a tool for quick reference for the name, class and source vocabulary details associated with a concept identifier.

## OHDSI SQL query

```sql
SELECT
  c.concept_id,
  c.concept_name,
  c.concept_code,
  c.concept_class_id,
  c.standard_concept,
  c.vocabulary_id
FROM @vocab_schema.concept AS c
WHERE c.concept_id = @concept_id
  AND GETDATE() BETWEEN valid_start_date AND valid_end_date
;
```

### Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  concept_id |  192671 |  Yes | 192671, Concept Identifier for "Gastrointestinal hemorrhage" |

### Output

|  Field |  Description |
| --- | --- |
|  Concept_ID |  Concept Identifier entered as input |
|  Concept_Name |  Name of the standard concept |
|  Concept_Code |  Concept code of the standard concept in the source vocabulary |
|  Concept_Class |  Concept class of standard vocabulary concept |
|  Standard_Concept |  'S' if concept is standard, 'C' if a classification concept or empty if non-standard. |
|  Vocabulary_ID |  Vocabulary the standard concept is derived from as vocabulary code |

### Sample output record

|  Field |  Value |
| --- | --- |
|  Concept_ID |  192671 |
|  Concept_Name |  Gastrointestinal hemorrhage |
|  Concept_Code |  74474003 |
|  Concept_Class |  Clinical finding |
|  Standard_Concept |  'S' |
|  Vocabulary_ID |  SNOMED |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT
