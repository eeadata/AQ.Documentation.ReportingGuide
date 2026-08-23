# Documentation

```{image} ../_static/table-icons/Documentation.png
:alt: Documentation
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the Documentation table is to communicate the documents requested in different tables such as documentation on data quality process, documentation on the models, the air quality plans etc.

Documentation (record) table has to be reported whenever a new document or an updated document is available.
Attributes which create unique identifier of each record: CountryCode, DataTable, DocumentType and DocumentId.

Updates of the Documentation table will be managed using reference/legacy data, where each addition and modification will be stamped with the ReportingTime.
Data products for public and reporters will present the records with the latest ReportingTime for each unique identifier.

## EEA extensions

Documentation table will be extended by EEA by:

- Country (for convenience), based on ISO2 country codes;
- ReportingTime, registering time of the latest reporting or modification for each record.

## Data management rules

More details about rules of data management related to documentation reporting are given above under the relevant tables. 

Records in Document table which do not have any correspondence (via DocumentId) to other tables will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| DOC_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| DOC_02 | DataTable | varchar(50) | string | PK | [datatable](https://dd.eionet.europa.eu/vocabulary/aq/datatable) |  |
| DOC_03 | DocumentType | varchar(50) | string | PK | [documenttype](https://dd.eionet.europa.eu/vocabulary/aq/documenttype) |  |
| DOC_04 | DocumentId | varchar(500) | string | PK |  | [MeasurementStation](MeasurementStation.md)<br>[SamplingProcess](SamplingProcess.md)<br>[ModelObjectiveEstimation](ModelObjectiveEstimation.md)<br>[AssessmentRegimeZone](AssessmentRegimeZone.md)<br>[CompliancePlanLink](CompliancePlanLink.md)<br>[SourceApportionment](SourceApportionment.md)<br>[PollutionLevelAdjustment](PollutionLevelAdjustment.md) |
| DOC_05 | DocumentAttachment | varchar(100) | attachment (R3 data type) |  |  |  |
| DOC_06 | DocumentOriginalURL | varchar(100) | string |  |  |  |

## Attribute details

### DOC_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Documentation.html#doc-01-countrycode)
**Content**

Country or territory ISO2 code.

### DOC_02 – DataTable


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Documentation.html#doc-02-datatable)
**Content**

Table name of origin.

### DOC_03 – DocumentType


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Documentation.html#doc-03-documenttype)
**Content**

Document content type.

### DOC_04 – DocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Documentation.html#doc-04-documentid)
**Content**

Identifier of the document given by data provider.

### DOC_05 – DocumentAttachment

**Content**

Attached document PDF.

### DOC_06 – DocumentOriginalURL


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Documentation.html#doc-06-documentoriginalurl)
**Content**

URL of the attached document PDF.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
DOC_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
DOC_02 | DataTable | Station | varchar(50) | string | ✓ | ✓
DOC_03 | DocumentType | NetworkDocument | varchar(50) | string | ✓ | ✓
DOC_04 | DocumentId | DOC_NET_DU01 | varchar(500) | string | ✓ | 
DOC_05 | DocumentAttachment | DUS_NET_DU01.pdf | varchar(100) | attachment (R3 data type) |  | 
DOC_06 | DocumentOriginalURL | www.dea.dustovia.dus/AQeREP/NET/DU01.pdf | varchar(100) | string |  |

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `Documentation`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
