# D18: Find ingredients for an indication provided as condition concept

## Description
This query provides all ingredients that are indicated for a certain indication. Indications have to be provided as SNOMED-CT concept ID (vocabulary_id=1).

## Query
```sql
SELECT DISTINCT
  ingredient.concept_id as ingredient_concept_id,
  ingredient.concept_name as ingredient_concept_name,
  ingredient.concept_code as ingredient_concept_code
FROM
  concept ingredient,
  concept_ancestor snomed,
  concept_ancestor ind,
  concept_relationship r
WHERE
  snomed.ancestor_concept_id = 253954 AND
  snomed.descendant_concept_id = r.concept_id_1 AND
  concept_id_2 = ind.ancestor_concept_id AND
  r.relationship_id in (247, 248) AND
  ind.descendant_concept_id = ingredient.concept_id AND
  ingredient.concept_level = 2 AND
  ingredient.vocabulary_id = 8 AND
  sysdate BETWEEN ingredient.valid_start_date AND ingredient.valid_end_date;
```

## Input

|  Parameter |  Example |  Mandatory |  Notes |
| --- | --- | --- | --- |
|  Indication Concept ID |  253954 |  Yes | SNOMED-CT indication concept ID |
|  As of date |  Sysdate |  No | Valid record as of specific date. Current date – sysdate is a default |

## Output

|  Field |  Description |
| --- | --- |
|  Ingredient_Concept_ID |  Concept ID of the ingredient |
|  Ingredient_Concept_Name |  Name of the ingredient |
|  Ingredient_Concept_Code |  Concept code of the ingredient |

## Sample output record

| Field |  Value |
| --- | --- |
|  Ingredient_Concept_ID |  1790868 |
|  Ingredient_Concept_Name |  Amikacin |
|  Ingredient_Concept_Code |  641 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
