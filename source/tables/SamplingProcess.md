# SamplingProcess

```{image} ../_static/table-icons/SamplingProcess.png
:alt: SamplingProcess
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the SamplingProcess table is to collect data on measurement techniques and methodologies. It describes the specific configurations of equipment, mostly through code listed values, and includes information on quality of the measurements as well as further details about the methods through attached documentation. The table includes corresponding times of operation.

SamplingProcess table has to be reported whenever new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode, ProcessId, AssessmentMethodId and ProcessActivityBegin.

Updates of the SamplingProcess table will not be time stamped, i.e. each update generates the only version of the table in reference/legacy data:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute, e.g. entering end date.
Validity of the new record will be tested using QC rules to be established, e.g. cross-checking relation between the code listed values.

Valid modifications of existing record in this table are:
- inserting ProcessActivityEnd,
- attaching new/different documentation,
- minor corrections, e.g. of wrong code list values.
Validity of the modifications of existing record will be tested using QC rules to be established.
Allowed modifications are not supposed to affect outcomes of compliance analysis and/or assessments.

Data products will present all records related to SamplingPoints reported recently for the UTD purpose.

## EEA extensions

SamplingProcess table will be extended by EEA by several attributes:
- Country, for convenience, based on ISO2 country codes,
- Pollutant, for convenience, based on code list,
- SamplingPointReferenceId, based on SamplingPoint table.

## Data management rules

In case where the ProcessActivityBegin was reported wrongly and/or the corresponding record needs to be deleted, the same value should be reported for ProcessActivityEnd.
Records where ProcessActivityBegin = ProcessActivityEnd will be flagged for deletion in the reference data flow.

It is recommended not to change DataQualityDocumentId, EquivalenceDemonstrationDocumentId or ProcessDocumentId in case of documentation update related to the same process. Instead, a new attachment should be uploaded in Document table re-using the same DocumentId. Previous versions of documentation will be kept in reference data.
In case where the same, e.g. DataQualityDocumentId, was used for all records and there is a need to modify documentation only for one specific process, it is recommended to create a new DataQualityDocumentId for that record in the SamplingProcess table, and then report old non-process-specific and new process-specific documents as attachments for that new DataQualityDocumentId as DocumentId in the Document table in a subsequent manner.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| SPP_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| SPP_02 | ProcessId | varchar(150) | string | PK |  |  |
| SPP_03 | AssessmentMethodId | varchar(50) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[SamplingPoint](SamplingPoint.md)<br>[SamplingPointLocation](SamplingPointLocation.md)<br>[ObservationMeasurementResult](ObservationMeasurementResult.md) |
| SPP_04 | ProcessActivityBegin | datetime | datetime | PK |  |  |
| SPP_05 | ProcessActivityEnd | datetime | datetime |  |  |  |
| SPP_06 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| SPP_07 | MeasurementType | varchar(50) | string |  | [measurementtype](https://dd.eionet.europa.eu/vocabulary/aq/measurementtype/view) |  |
| SPP_08 | Method | varchar(50) | string |  | [measurementmethod](https://dd.eionet.europa.eu/vocabulary/aq/measurementmethod/view) |  |
| SPP_09 | Equipment | varchar(50) | string |  | [measurementequipment](https://dd.eionet.europa.eu/vocabulary/aq/measurementequipment/view) |  |
| SPP_10 | AnalyticalTechnique | varchar(50) | string |  | [analyticaltechnique](https://dd.eionet.europa.eu/vocabulary/aq/analyticaltechnique/view) |  |
| SPP_11 | EquivalenceDemonstrated | varchar(50) | string |  | [equivalencedemonstrated](https://dd.eionet.europa.eu/vocabulary/aq/equivalencedemonstrated) |  |
| SPP_12 | DataQualityDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |
| SPP_13 | EquivalenceDemonstrationDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |
| SPP_14 | ProcessDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |

## Attribute details

### SPP_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-01-countrycode)
**Content**

Country or territory ISO2 code.

### SPP_02 – ProcessId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-02-processid)
**Content**

Identifier of the sampling process, given by data provider.

**Remarks**

The same ProcessId can be re-used for the same equipment configurations under different sampling points (AssessmentMethodId).

### SPP_03 – AssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-03-assessmentmethodid)
**Content**

Identifier of the assessment method (sampling point) given by data provider.

**Remarks**

A sampling point (AssessmentMethodId) can be closed (set as inactive) by ending the ProcessId (specifying ProcessActivityEnd).
The same sampling point can be re-opened, also with the same ProcessId, by adding new record with new ProcessActivityBegin.

### SPP_04 – ProcessActivityBegin


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-04-processactivitybegin)
**Content**

Start time of the measurement process.

**Remarks**

If there is more than one ProcessId within the same AssessmentMethodId, then ProcessActivityBegin - ProcessActivityEnd should not overlap within the same AssessmentMethodId.

### SPP_05 – ProcessActivityEnd


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-05-processactivityend)
**Content**

End time of the measurement process.

### SPP_06 – PollutantId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-06-pollutantid)
**Content**

Code of the air pollutant being measured, as per Data Dictionary standards.

### SPP_07 – MeasurementType


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-07-measurementtype)
**Content**

Classification of measurement methods into generic types.

### SPP_08 – Method


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-08-method)
**Content**

Specific method used for measuring air pollutants.

### SPP_09 – Equipment


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-09-equipment)
**Content**

Equipment used for air pollutant measurement.

### SPP_10 – AnalyticalTechnique


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-10-analyticaltechnique)
**Content**

Analytical technique used for measuring pollutants.

### SPP_11 – EquivalenceDemonstrated


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-11-equivalencedemonstrated)
**Content**

Status of equivalence demonstration according to regulatory requirements.

### SPP_12 – DataQualityDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-12-dataqualitydocumentid)
**Content**

Identifier of the Quality Assurance report given by data provider.

### SPP_13 – EquivalenceDemonstrationDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-13-equivalencedemonstrationdocumentid)
**Content**

Identifier of the Equivalence demonstration report given by data provider.

### SPP_14 – ProcessDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingProcess.html#spp-14-processdocumentid)
**Content**

Identifier of the documentation on process and data quality given by data provider.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
SPP_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
SPP_02 | ProcessId | SPP_DU0001_0005_1 | varchar(150) | string | ✓ | 
SPP_03 | AssessmentMethodId | SPO_DU0001_0005_100 | varchar(50) | string | ✓ | 
SPP_04 | ProcessActivityBegin | 25/06/2013 00:00 | datetime | datetime | ✓ | 
SPP_05 | ProcessActivityEnd | null | datetime | datetime |  | 
SPP_06 | PollutantId | 5 | int | numeric |  | ✓
SPP_07 | MeasurementType | automatic | varchar(50) | string |  | ✓
SPP_08 | Method | BETA | varchar(50) | string |  | ✓
SPP_09 | Equipment | BETA1020 | varchar(50) | string |  | ✓
SPP_10 | AnalyticalTechnique | null | varchar(50) | string |  | ✓
SPP_11 | EquivalenceDemonstrated | yes | varchar(50) | string |  | ✓
SPP_12 | DataQualityDocumentId | DOC_DQ_SPP_DU0005_1 | varchar(150) | string |  | 
SPP_13 | EquivalenceDemonstrationDocumentId | DOC_EQ_SPP_DU0005_1 | varchar(150) | string |  | 
SPP_14 | ProcessDocumentId | DOC_PR_SPP_DU0005_1 | varchar(150) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `SamplingProcess`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)