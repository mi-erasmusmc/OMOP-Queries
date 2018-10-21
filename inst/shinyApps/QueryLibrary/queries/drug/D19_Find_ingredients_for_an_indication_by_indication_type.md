# D19: Find ingredients for an indication by indication type

## Description
This query provides all ingredients that are indicated for a certain condition. In addition, it provides the type of indication: FDA-approved, off-label (both based on FDB indication classes) and may treat and may prevent (both based on NDF-RT). Indications have to be provided as FDB indications (vocabulary_id=19) or NDF-RT (vocabulary_id=7).

## Query
```sql
SELECT DISTINCT
  ingredient.concept_id as ingredient_concept_id,
  ingredient.concept_name as ingredient_concept_name,
  ingredient.concept_code as ingredient_concept_code,
  rn.relationship_name as indication_type,
  indication_relation.relationship_id
FROM
  concept_relationship indication_relation
INNER JOIN
  concept_ancestor a ON a.ancestor_concept_id=indication_relation.concept_id_2
INNER JOIN
  concept ingredient ON ingredient.concept_id=a.descendant_concept_id
INNER JOIN
  relationship rn ON rn.relationship_id = indication_relation.relationship_id
WHERE
  indication_relation.concept_id_1 = 4345991 AND
  ingredient.vocabulary_id = 8 AND
  ingredient.concept_level = 2 AND
  indication_relation.relationship_id in (21,23,155,157,126,127,240,241,281,282) AND
  sysdate BETWEEN ingredient.valid_start_date AND ingredient.valid_end_date;
```

## Input

| Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Indication Concept ID |  4345991 |  Yes | FDB indication concept for 'Vomiting' |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | --- |
|  Ingredient_Concept_ID |  Concept ID of the ingredient |
|  Ingredient_Concept_Name |  Name of the ingredient |
|  Ingredient_Concept_Code |  Concept code of the ingredient |
|  Indication_Type |  One of the FDB, NDF-RT or OMOP inferred indication types |
|  Relationship_id |  Corresponding relationship ID to the Indication Type |

## Sample output record

|  Field |  Value |
| --- | --- |
|  Ingredient_Concept_ID |  733008 |
|  Ingredient_Concept_Name |  Perphenazine |
|  Ingredient_Concept_Code |  8076 |
|  Indication_Type |  Inferred ingredient of (OMOP) |
|  Relationship_id |  281 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
