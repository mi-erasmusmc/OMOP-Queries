---
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE)
```

# CS01: Care site place of service counts

## Description
This query is used to count the care sites associated with the place of service type. This query is only available from CDM V4 and above.

## Query
```sql
select cs.place_of_service_concept_id, count(1) places_of_service_count
from @cdm.care_site cs
group by cs.place_of_service_concept_id
order by 1;
```

## Input

None

## Output

| Field |  Description |
| ---------- | ---------------------------------------------- |
| place_of_service_concept_id | A foreign key that refers to a place of service concept identifier in the vocabulary. |
| places_of_service_count |   |

## Sample output record

| Field |  Description |
| --- | --- |
| place_of_service_concept_id |  8546 |
| places_of_service_count |  1 |

## Documentation
https://github.com/OHDSI/CommonDataModel/wiki/
