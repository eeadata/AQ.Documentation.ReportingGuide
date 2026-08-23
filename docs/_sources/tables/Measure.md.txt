# Measure

```{image} ../_static/table-icons/Measure.png
:alt: Measure
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the Measure table is to provide information on the different measures contained in the groups of measures. It describes the the spatial scale of the measures, their type and classification as well as sector of impact. The table includes also operational characteristics of measures such as: responsible entity, implementation timing, costs, status and expected time of full effect or reason if measure has not been used.

Measure (record) table has to be reported whenever a new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode, MeasureGroupId and MeasureId.

Updates of the Measure table will be managed using reference/legacy data, where each addition and modification will be stamped with ReportingTime:
- addition of new record is understood as addition of new combination of values for the attributes creating unique identifier,
- modification of existing record is understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against relevant code lists and tested for coherence.

Valid modifications of existing record in this table are:
- modifying ResponsibleEntity, ImplementationBegin and/or End, MeasureCost, FullEffectDate, MeasureStatus or ReasonIfMeasureNotUsed,
- minor corrections e.g. of name, code or type.
Validity of the modifications of existing record will be tested using QC (rules to be established).
Allowed modifications may affect outcomes of scenario analysis and/or assessments of measures, therefore re-submissions for past years, for which plans reporting has been already done, will require additional tests vs reference/legacy data before official release of such data is granted.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently - i.e. with the latest ReportingTime for each unique combination of CountryCode, MeasureGroupId and MeasureId, highlighting the differences between validated reports and recent reports in case of re-submissions.

Deletion of an existing record will be possible by flagging the Deletion attribute. After QCs (rules to be established), all associated records in other tables will be flagged as deleted.

## EEA extensions

Measure table will be extended by several attributes:
- Country (for convenience), based on ISO2 country codes,
- ReportingTime, registering time of the latest reporting or modification for each record.

## Data management rules

Since the unique identifier of each record consists of CountryCode, MeasureGroupId and MeasureId, the MeasureIds can be handled as static set of measures (with code, name, type, source sector) and can be re-used in different MeasureGroupIds - which can be then used for giving spatial and temporal context to the measures (spatial scale, responsible entity, implementation timing, costs, etc.).

Deletion of an existing record will be possible via the Deletion attribute (by reporting value = 1).

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| MEA_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| MEA_02 | MeasureGroupId | varchar(50) | string | PK |  | [ScenarioMeasure](ScenarioMeasure.md) |
| MEA_03 | MeasureId | varchar(50) | string | PK |  |  |
| MEA_04 | MeasureNationalCode | varchar(50) | string |  |  |  |
| MEA_05 | MeasureName | varchar(150) | string |  |  |  |
| MEA_06 | MeasureClassification | varchar(50) | string |  | [measureclassification](https://dd.eionet.europa.eu/vocabulary/aq/measureclassification/view) |  |
| MEA_07 | MeasureType | varchar(50) | string |  | [measuretype](https://dd.eionet.europa.eu/vocabulary/aq/measuretype/view) |  |
| MEA_08 | SourceSector | varchar(50) | string |  | [sourcesectors](https://dd.eionet.europa.eu/vocabulary/aq/sourcesectors/view) |  |
| MEA_09 | SpatialScale | varchar(50) | string |  | [spatialscale](https://dd.eionet.europa.eu/vocabulary/aq/spatialscale/view) |  |
| MEA_10 | ImplementationBegin | date | datetime |  |  |  |
| MEA_11 | ImplementationEnd | date | datetime |  |  |  |
| MEA_12 | MeasureCost | decimal(18,2) | numeric |  |  |  |
| MEA_13 | FullEffectDate | date | datetime |  |  |  |
| MEA_14 | MeasureStatus | varchar(50) | string |  | [measureimplementationstatus](https://dd.eionet.europa.eu/vocabulary/aq/measureimplementationstatus/view) |  |
| MEA_15 | ReasonIfMeasureNotUsed | varchar(50) | string |  | [reasonifmeasurenotused](https://dd.eionet.europa.eu/vocabulary/aq/reasonifmeasurenotused) |  |
| MEA_16 | Deletion | bit | boolean |  |  |  |

## Attribute details

### MEA_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-01-countrycode)
**Content**

Country or territory ISO2 code.

### MEA_02 – MeasureGroupId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-02-measuregroupid)
**Content**

Identifier of the pollution reduction for measure group, given by data provider.

### MEA_03 – MeasureId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-03-measureid)
**Content**

Identifier of the pollution reduction measure, given by data provider.

### MEA_04 – MeasureNationalCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-04-measurenationalcode)
**Content**

Unique local code assigned to the measure by the data provider.

### MEA_05 – MeasureName


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-05-measurename)
**Content**

Name or title of the pollution reduction measure.

### MEA_06 – MeasureClassification


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-06-measureclassification)
**Content**

Classification of the measure based on regulatory categories.

### MEA_07 – MeasureType


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-07-measuretype)
**Content**

Description of the high-level implementation mechanism or scope of the measure.

### MEA_08 – SourceSector


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-08-sourcesector)
**Content**

Economic or activity sector targeted by the measure (e.g., transport, energy, industry).

**Remarks**

It can be tested against the SourceSector of SourceApportionment which was used as base for corresponding ScenarioId.

### MEA_09 – SpatialScale


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-09-spatialscale)
**Content**

Geographical coverage of the measure (e.g., local, national, EU-wide).

**Remarks**

It can be tested against the SpatialScale of SourceApportionment which was used as base for corresponding ScenarioId.

### MEA_10 – ImplementationBegin


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-10-implementationbegin)
**Content**

Start date for implementing the measure.

### MEA_11 – ImplementationEnd


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-11-implementationend)
**Content**

End date for implementing the measure.

### MEA_12 – MeasureCost


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-12-measurecost)
**Content**

Estimated costs for implementing the measure over its lifetime.

### MEA_13 – FullEffectDate


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-13-fulleffectdate)
**Content**

Date when the measure is expected to reach its full impact.

### MEA_14 – MeasureStatus


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-14-measurestatus)
**Content**

Current status of the measure (e.g., planned, in progress, completed).

### MEA_15 – ReasonIfMeasureNotUsed


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-15-reasonifmeasurenotused)
**Content**

Explanation or justification if the measure was not implemented.

### MEA_16 – Deletion


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Measure.html#mea-16-deletion)
**Content**

Flag to indicate that this element must be deleted

**Remarks**

Y/N

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
MEA_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
MEA_02 | MeasureGroupId | MG1_SCE_ZON_DU000B_00005_LV_H_daysAbove | varchar(50) | string | ✓ | 
MEA_03 | MeasureId | Measure_1256 | varchar(50) | string | ✓ | 
MEA_04 | MeasureNationalCode | Measure_1256 | varchar(50) | string |  | 
MEA_05 | MeasureName | Industrial Emission Control | varchar(150) | string |  | 
MEA_06 | MeasureClassification | emissioncontrol | varchar(50) | string |  | ✓
MEA_07 | MeasureType | outside | varchar(50) | string |  | ✓
MEA_08 | SourceSector | industry | varchar(50) | string |  | ✓
MEA_09 | SpatialScale | local | varchar(50) | string |  | ✓
MEA_10 | ImplementationBegin | 01-02-2025 | date | datetime |  | 
MEA_11 | ImplementationEnd | 31-12-2027 | date | datetime |  | 
MEA_12 | MeasureCost | null | decimal(18,2) | numeric |  | 
MEA_13 | FullEffectDate | null | date | datetime |  | 
MEA_14 | MeasureStatus | implementation | varchar(50) | string |  | ✓
MEA_15 | ReasonIfMeasureNotUsed | null | varchar(50) | string |  | ✓
MEA_16 | Deletion | 0 | bit | boolean |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `Measure`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
