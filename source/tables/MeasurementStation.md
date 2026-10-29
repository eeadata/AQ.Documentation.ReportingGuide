# MeasurementStation

```{image} ../_static/table-icons/MeasurementStation.png
:alt: MeasurementStation
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the MeasurementStation table is to collect data on air quality measuring stations. It includes their EoI codes, names, as well as air quality networks they belong to and time zone in which the networks operate.

MeasurementStation table has to be reported whenever new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode and StationEoICode.

Updates of the MeasurementStation table will be managed using reference/legacy data, where each addition and modification will be stamped with ReportingTime:
- addition of new record is understood as addition of new combination of values for the attributes creating unique identifier,
- modification of existing record is understood as modification of a value for any other attribute.

Validity of the new record will be tested using QC rules to be established, e.g. testing validity of EoI codes.

Valid modifications of existing record in this table are minor corrections, e.g. of NetworkName, StationNationalCode, StationName or Timezone, which are not considered as station re-location into new conditions.
Validity of the modifications of existing record will be tested using QC rules to be established.
Allowed modifications are not supposed to affect outcomes of compliance analysis and/or assessments.

Data products will present the records with the latest ReportingTime for each unique combination of CountryCode and StationEoICode.

## EEA extensions

MeasurementStation table will be extended by EEA by several attributes:
- Country (for convenience), based on ISO2 country codes,
- City and CityCode, based on intersection of station location with city geometry,
- ReportingTime, registering time of the latest reporting or modification for each record.

## Data management rules

For traceability purposes it is not allowed to change StationEoICode even in case of significant relocation.

It is recommended not to change NetworkDocumentId in case of documentation update related to the same station/network. Instead, a new attachment should be uploaded in Documentation table re-using the same DocumentId. Previous versions of documentation will be kept in reference data.
In case where the same NetworkDocumentId was used for all stations and there is a need to modify documentation only for one specific station, it is recommended to create a new NetworkDocumentId for that record in MeasurementStation table. Then report old network-specific and new station-specific documents as attachments for that new NetworkDocumentId in the Documentation table in a subsequent manner.

Station without active sampling points will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| STA_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| STA_02 | StationEoICode | varchar(10) | string | PK |  | [SamplingPoint](SamplingPoint.md) |
| STA_03 | NetworkId | varchar(50) | string |  |  |  |
| STA_04 | NetworkName | varchar(150) | string |  |  |  |
| STA_05 | NetworkOrganisationalLevel | varchar(20) | string |  | [administrativelevel](https://dd.eionet.europa.eu/vocabulary/aq/administrativelevel/view) |  |
| STA_06 | Timezone | varchar(20) | string |  | [timezone](https://dd.eionet.europa.eu/vocabulary/aq/timezone) |  |
| STA_07 | StationNationalCode | varchar(50) | string |  |  |  |
| STA_08 | StationName | varchar(100) | string |  |  |  |
| STA_09 | NetworkDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |

## Attribute details

### STA_01 – CountryCode


**Content**

Country or territory ISO2 code.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-01-countrycode)

### STA_02 – StationEoICode


**Content**

EoI (Exchange of Information) code of the air quality measurement station, as in AirBase, either re-used or given by data provider following strict rules.

**Code list / reference**

There will be no specific code list in Data Dictionary but the MeasurementStation table in reference data flow will serve as code list for StationEoICode values.

**Remarks**

StationEoICode must be always provided and cannot be modified.

Station will become inactive if all sampling points in that station are inactive.

The same Station can become active again if there are new active sampling points or existing sampling points become active again.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-02-stationeoicode)

### STA_03 – NetworkId


**Content**

Identifier of the air quality network, given by data provider.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-03-networkid)

### STA_04 – NetworkName


**Content**

Name of the air quality measurement network, given by data provider.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-04-networkname)

### STA_05 – NetworkOrganisationalLevel


**Content**

Level of administration or organization responsible for the air quality network (national, regional, local).

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-05-networkorganisationallevel)

### STA_06 – Timezone


**Content**

Time zone in which air quality measurements and statistics are recorded.

**Remarks**

TimeZone must be provided and will be used for calculations of AQ statistics.

If TimeZone is modified, all statistics will be recalculated accordingly.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-06-timezone)

### STA_07 – StationNationalCode


**Content**

National code of the air quality measurement station, given by data provider.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-07-stationnationalcode)

### STA_08 – StationName


**Content**

Name of the air quality measurement station.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-08-stationname)

### STA_09 – NetworkDocumentId


**Content**

Identifier of the documentation on network and station.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/MeasurementStation.html#sta-09-networkdocumentid)

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
STA_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
STA_02 | StationEoICode | DU0001 | varchar(10) | string | ✓ | 
STA_03 | NetworkId | NET_DU01 | varchar(50) | string |  | 
STA_04 | NetworkName | Dustovia Capital | varchar(150) | string |  | 
STA_05 | NetworkOrganisationalLevel | regional | varchar(20) | string |  | ✓
STA_06 | Timezone | UTC-01 | varchar(20) | string |  | ✓
STA_07 | StationNationalCode | DU01_01 | varchar(50) | string |  | 
STA_08 | StationName | Rivny-Suburb-A | varchar(100) | string |  | 
STA_09 | NetworkDocumentId | DOC_NET_DU01 | varchar(150) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

<!--
The complete set of examples is available in the Excel workbook, worksheet `SamplingPoint`.
-->

> **Note:** The example file is temporarily unavailable while it is being updated. The updated version will be made available once the revision is complete.

<!--
<a href="../_static/R3_v501_AQ_Reporting_guide_example.xlsx" target="_blank" rel="noopener noreferrer">Open complete examples workbook</a>
-->