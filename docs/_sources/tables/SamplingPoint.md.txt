# SamplingPoint

```{image} ../_static/table-icons/SamplingPoint.png
:alt: SamplingPoint
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the SamplingPoint table is to ensure the link between the AssessmentMethodId, the SamplingPointReferenceId and the StationEoiCode.

Attributes which create unique identifier of each record: CountryCode and AssessmentMethodId.

Updates of the SamplingPoint table will be managed using reference/legacy data, where each addition and modification will be stamped with ReportingTime:
- addition of new record is understood as addition of new combination of values for the attributes creating unique identifier,
- modification of existing record is understood as modification of a value for any other attribute.
Validity of the new record and modifications will be tested using QC (rules to be established) - e.g. cross checking against existing records in Station table.
Allowed modifications are not supposed to affect outcomes of compliance analysis and/or assessments.

## EEA extensions

SamplingPoint table will be extended by EEA by several attributes:
- Country (for convenience), based on ISO2 country codes,
- Pollutant (for convenience), based on code list,
- SamplingPointStatus, based on values in SamplingProcess.ProcessActivityEnd (if all ProcessId have ProcessActivityEnd populated the SamplingPointStatus is 'inactive', otherwise it is 'active'),
- ReportingTime, registering time of the latest reporting or modification for each record.

## Data management rules

At the time of creating the first version of reference data, the EEA will establish list of values of SamplingPointReferenceId corresponding to AssessmentMethodIds using rule:

```text
'SPO' + EoI code + pollutant code + ordering index
```

(see Identifiers worksheet).
From that moment, countries should generate the SamplingPointReferenceId for all new sampling points/AssessmentMethodId.

<b>SamplingPointReferenceId cannot be modified and cannot be re-used (e.g. after deletion of a sampling point).</b>

SamplingPointReferenceId serves as reference/mapping identifier for situations when a country or a network changes the naming convention for all its measurements (sampling point identifiers); in such cases, the new identifiers (AssessmentMethodIds) should be mapped by reporting authorities to SamplingPointReferenceId corresponding to the same sampling points.
The reference data flow will keep both the old and the new identifiers but it will be able to maintain and present continuity of measurement configurations.
Situation of changes in naming convention is different from cases when sampling point needs to be closed due to its relocation or changes in air quality conditions (e.g. city sprawl). In such cases all processes within the sampling point should be ended and no new measurement results should be reported for that AssessmentMethodId.
The sampling point will be set as 'inactive' in the reference data flow and this will apply as well to the SamplingPointReferenceId.
The reporting authority should then create a new sampling point with a new SamplingPointReferenceId.

It is up to the reporting authority to decide when the changes in surrounding conditions are significant enough to inactivate and create sampling points.

SamplingPoint without both active SamplingProcess active SamplingPointLocation and without any ObservationMeasurementResult records with valid values will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| SPO_01 | CountryCode | varchar(2) | string | PK | [](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| SPO_02 | AssessmentMethodId | varchar(100) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[SamplingProcess](SamplingProcess.md)<br>[SamplingPointLocation](SamplingPointLocation.md)<br>[ObservationMeasurementResult](ObservationMeasurementResult.md) |
| SPO_03 | SamplingPointReferenceId | varchar(32) | string |  |  |  |
| SPO_04 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| SPO_05 | StationEoICode | varchar(10) | string |  |  | [MeasurementStation](MeasurementStation.md) |

## Attribute details

### SPO_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPoint.html#spo-01-countrycode)
**Content**

Country or territory ISO2 code.


### SPO_02 – AssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPoint.html#spo-02-assessmentmethodid)
**Content**

Identifier of the assessment method (sampling point), given by data provider.

**Remarks**

A sampling point (AssessmentMethodId) can be closed (set as inactive) by ending the ProcessId (specifying ProcessActivityEnd).

The same sampling point (AssessmentMethodId) can be re-open (also with the same ProcessId) by adding new record with new ProcessActivityBegin.

### SPO_03 – SamplingPointReferenceId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPoint.html#spo-03-samplingpointreferenceid)
**Content**

Reference identifier of the assessment method (sampling point), either re-used or given by data provider following strict rules.

**Remarks**

Following rules of SPO reference code, unique within CountryCode reported and it can serve as reference code list.

### SPO_04 – PollutantId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPoint.html#spo-04-pollutantid)
**Content**

Code of the air pollutant being measured, as per Data Dictionary standards.

**Remarks**

Only one for the same AssessmentMethodId/SamplingPointReferenceId.

### SPO_05 – StationEoICode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPoint.html#spo-05-stationeoicode)
**Content**

EoI (Exchange of Information) code of the air quality measurement station, as in AirBase, either re-used or given by data provider following strict rules.

**Code list / reference**

There will be no specific code list in Data Dictionary but the Station table in reference data flow will serve as code list for AirQualityStationEoICode values.

**Remarks**

StationEoICode must be always provided and cannot be modified.

Station will become inactive if all sampling points in that station are inactive.

The same Station can become active again if there are new active sampling points or existing sampling points become active again.

It will be cross-checked against Station table.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
SPO_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
SPO_02 | AssessmentMethodId | SPO_DU0001_0005_100 | varchar(100) | string | ✓ | 
SPO_03 | SamplingPointReferenceId | SPOref_DU0001_0005_1 | varchar(32) | string |  | 
SPO_04 | PollutantId | 5 | int | numeric |  | ✓
SPO_05 | StationEoICode | DU0001 | varchar(10) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `SamplingPoint`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)