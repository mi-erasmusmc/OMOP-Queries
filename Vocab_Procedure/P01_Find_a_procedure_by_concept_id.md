# P01: Find procedure by concept id

This query enables extraction of concept details associated with a concept identifier. The query is a tool for quick reference for the name, class, level and source vocabulary details associated with a concept identifier.

Please note that along with concept details, the query returns a flag indicating whether the concept is a procedure concept (part of the PROCEDURE domain). Standard concepts in the Procedure domain include the following:

 * SNOMED-CT procedure concepts
 * CPT-4 / HCPCS / ICD9 procedure concepts
 
If the Concept is not in the Prodedure domain, the query still returns the concept details with the Is_Procedure_Concept_Flag field set to ‘No’.

### Sample query

The following is a sample run of the query to run a search for procedure concept ID of 4336464. The input parameters are highlighted.

```sql
SELECT
  c.concept_id       AS procedure_concept_id,
  c.concept_name     AS procedure_concept_name,
  c.concept_code     AS procedure_concept_code,
  c.concept_class_id AS procedure_concept_class,
  c.vocabulary_id    AS procedure_concept_vocab_id,
  CASE c.standard_concept
    WHEN 'S' THEN TRUE
    ELSE FALSE
  END                AS is_standard_concept,
  CASE lower(c.domain_id)
    WHEN 'procedure' THEN TRUE
    ELSE FALSE
  END                AS is_procedure_concept_flag
FROM concept c
WHERE c.concept_id = 4336464 -- PARAMETER
      AND sysdate BETWEEN c.valid_start_date AND c.valid_end_date -- PARAMETER
;
```

### Input

| Parameter	| Example | Mandatory | Notes |
| --- | --- | --- | --- |
| Concept ID | 4336464 | Yes | Concept Identifier for ‘Coronary artery bypass graft’ |
| As of date | Sysdate | No | Valid record as of specific date. Current date – sysdate is a default |

### Output

|  Field |  Description |
| --- | --- |
|  Procedure_Concept_ID |  Concept ID of entity with string match on name or synonym concept |
|  Procedure_Name |  Concept name of entity with string match on name or synonym concept |
|  Procedure_Code |  Concept code of entity with string match on name or synonym concept |
|  Procedure_Concept_Class |  Concept class of entity with string match on name or synonym concept |
|  Procedure_Vocabulary_ID |  Vocabulary the concept with string match is derived from as vocabulary ID |
|  Is_Standard_concept |  Flag indicating Whether the concept is a standard concept |
|  Is_Procedure_Concept_Flag | Flag indicating whether the Concept ID belongs to a procedure concept |

### Sample output record

| Field |  Value |
| --- | --- |
|  Procedure_Concept_ID |  4336464 |
|  Procedure_Name |  Coronary artery bypass graft |
|  Procedure_Code |  232717009 |
|  Procedure_Concept_Class |  Procedure |
|  Procedure_Vocabulary_ID |  SNOMED |
|  Is_Standard_concept |  TRUE |
|  Is_Procedure_Concept_Flag |  TRUE |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT
