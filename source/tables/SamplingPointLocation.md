# SamplingPointLocation

```{image} ../_static/table-icons/SamplingPointLocation.png
:alt: SamplingPointLocation
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the SamplingPoint table is to collect data on air quality sampling locations. It describes their identifiers, coordinates and other area and location characteristics. The table includes corresponding times of location characteristic effectiveness.

SamplingPointLocation table has to be reported whenever new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode, AssessmentMethodId and LocationBegin.

Updates of the SamplingLocation table will not be time stamped, i.e. each update generates the only version of the table in reference/legacy data:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute, e.g. entering end date.
Validity of the new record will be tested using QC rules to be established, e.g. cross-checking relation between the code listed values.

Valid modifications of existing record in this table are minor corrections, e.g. of building distance or coordinates, or altitude, which are not considered as SamplingPoint re-location into new conditions.
Validity of the modifications of existing record will be tested using QC rules to be established.
Allowed modifications are not supposed to affect outcomes of compliance analysis and/or assessments.

Data products will present all records related to SamplingPoints reported recently for the UTD purpose.

## EEA extensions

SamplingPointLocation table will be extended by EEA by several attributes:
- Country, for convenience, based on ISO2 country codes,
- Pollutant, for convenience, based on code list,
- SamplingPointStatus, based on values in SamplingLocation.LocationEnd  (if all AssessmentMethodId have LocationEnd populated the SamplingPointStatus is 'inactive', otherwise it is 'active'),,
- X and Y, based on coordinates re-projected to SRID3035,
- grid number identifiers, based on X and Y in SRID3035,
- SamplingPointType, following the previous version of sampling point type classification (traffic, background,industrial); the new type SamplingPointCategory for closed/inactive sampling points will be mapped to the older types using road traffic, background and industry categories, unless countries re-submit meta-data for these sampling points and set their own values; countries should set their own values of SamplingPointCategory for all active sampling points.

## Data management rules

In case where the LocationBegin was reported wrongly and/or the corresponding record needs to be deleted, the same value should be reported for LocationEnd. Records where LocationBegin = LocationEnd will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| SPL_01 | CountryCode | varchar(2) | string | PK |  |  |
| SPL_02 | AssessmentMethodId | varchar(100) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[SamplingPoint](SamplingPoint.md)<br>[SamplingProcess](SamplingProcess.md)<br>[ObservationMeasurementResult](ObservationMeasurementResult.md) |
| SPL_03 | LocationBegin | datetime | datetime | PK |  |  |
| SPL_04 | LocationEnd | datetime | datetime |  |  |  |
| SPL_05 | StationArea | varchar(100) | string |  | [areaclassification](https://dd.eionet.europa.eu/vocabulary/aq/areaclassification/view) |  |
| SPL_06 | SamplingPointCategory | varchar(50) | string |  | Code list to be developed |  |
| SPL_07 | Hotspot | bit | boolean |  |  |  |
| SPL_08 | Supersite | bit | boolean |  |  |  |
| SPL_09 | Latitude | decimal(8,4) | numeric |  |  |  |
| SPL_10 | Longitude | decimal(8,4) | numeric |  |  |  |
| SPL_11 | Altitude | decimal(10,1) | numeric |  |  |  |
| SPL_12 | InletHeight | decimal(10,1) | numeric |  |  |  |
| SPL_13 | BuildingDistance | decimal(10,1) | numeric |  |  |  |
| SPL_14 | KerbDistance | decimal(10,1) | numeric |  |  |  |
| SPL_15 | EmissionSourceDistance | decimal(10,1) | numeric |  |  |  |


```{note}
Attributes with ReportNet3 data type `date` or `datetime` shall use the ISO 8601 format. Date-time values may include a local UTC offset.
```

## Attribute details

### SPL_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-01-countrycode)
**Content**

Country or territory ISO2 code.

### SPL_02 – AssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-02-assessmentmethodid)
**Content**

Identifier of the assessment method (sampling point), given by data provider.

### SPL_03 – LocationBegin


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-03-locationbegin)
**Content**

Start time of the location characteristic(s).

**Remarks**

The permissible modifications in the location characteristics will be verified by adequate QC.

### SPL_04 – LocationEnd


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-04-locationend)
**Content**

End time of the location characteristic(s).

### SPL_05 – StationArea


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-05-stationarea)
**Content**

Classification of the air quality measurement station’s area (urban, suburban, rural, etc.).

**Remarks**

A change in station area implies closing the associated sampling points by ending the SamplingProcess, declaring a new station and the associated new sampling points.

### SPL_06 – SamplingPointCategory


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-06-samplingpointcategory)
**Content**

Intention or reason for placing sampling point.

**Code list / reference**

Code list to be developed.

**Remarks**

Potential categories: traffic, background, industrial, port, airport, residential heating, multisource.

### SPL_07 – Hotspot


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-07-hotspot)
**Content**

Indicator if the measurement site is considered as a hotspot.

**Remarks**

Y/N.

Hotspot relates to the provisions of the recasted Air Quality Directive 2024/2881, Article 4(27) and others.

### SPL_08 – Supersite


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-08-supersite)
**Content**

Indicator if the measurement site is classified as a "Super Site" for advanced monitoring.

**Remarks**

Y/N.

### SPL_09 – Latitude


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-09-latitude)
**Content**

Latitude coordinate of the air quality station location (decimal degrees).

### SPL_10 – Longitude


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-10-longitude)
**Content**

Longitude coordinate of the air quality station location (decimal degrees).

### SPL_11 – Altitude


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-11-altitude)
**Content**

Altitude of the air quality station location in meters above sea level.

### SPL_12 – InletHeight


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-12-inletheight)
**Content**

Height of the sampling inlet where air quality measurements are taken, in meters.

### SPL_13 – BuildingDistance


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-13-buildingdistance)
**Content**

Horizontal distance from the sampling inlet to the nearest building, in meters.

### SPL_14 – KerbDistance


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-14-kerbdistance)
**Content**

Horizontal distance from the sampling inlet to the nearest road kerb, in meters.

### SPL_15 – EmissionSourceDistance


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SamplingPointLocation.html#spl-15-emissionsourcedistance)
**Content**

Horizontal distance from the main emission source, in meters.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
SPL_01 | CountryCode | DU | varchar(2) | string | ✓ | 
SPL_02 | AssessmentMethodId | SPO_DU0001_0005_100 | varchar(100) | string | ✓ | 
SPL_03 | LocationBegin | 2013-06-25T00:00 | datetime | datetime | ✓ |
SPL_04 | LocationEnd | null | datetime | datetime |  | 
SPL_05 | StationArea | urban | varchar(100) | string |  | ✓
SPL_06 | SamplingPointCategory | background | varchar(50) | string |  | ✓
SPL_07 | Hotspot | N | bit | boolean |  | 
SPL_08 | Supersite | N | bit | boolean |  | 
SPL_09 | Latitude | 43.60625 | decimal(8,4) | numeric |  | 
SPL_10 | Longitude | 33.093242 | decimal(8,4) | numeric |  | 
SPL_11 | Altitude | 21 | decimal(10,1) | numeric |  | 
SPL_12 | InletHeight | 2 | decimal(10,1) | numeric |  | 
SPL_13 | BuildingDistance | 10 | decimal(10,1) | numeric |  | 
SPL_14 | KerbDistance | 5 | decimal(10,1) | numeric |  | 
SPL_15 | EmissionSourceDistance | 5 | decimal(10,1) | numeric |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `SamplingPointLocation`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
