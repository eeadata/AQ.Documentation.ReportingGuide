# ZoneGeometry

```{image} ../_static/table-icons/ZoneGeometry.png
:alt: ZoneGeometry
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the ZoneGeometry table is to collect information on air quality geometries.

ZoneGeometry table has to be reported whenever new information or an update of existing information is available.
Attributes which create unique identifier of each record: **CountryCode** and **ZoneId**.

Updates of the ZoneGeometry table will not be time stamped - i.e. each update generates the only version of the table in reference/legacy data:
- either as addition of a new zone geometry;
- or modification of an existing geometry.
Validity of a new record will be tested using QC procedures (rules to be established), for example checking OGC compliance of the reported geometry.

Validity of modifications of existing geometries will also be tested through QC procedures.
Allowed modifications are not supposed to affect outcomes of compliance analysis and/or assessments and will therefore be strictly limited to fulfil certain conditions (e.g. area difference thresholds).

Data products for the public will present records validated at the latest deadline.
Data products for reporters will present records as most recently reported, highlighting differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

ZoneGeometry table will be extended by EEA in the reference/legacy data flow with a **Country** attribute.

In addition, a gridded version of the zones will be generated:

### ZoneGeometryGrid

ZoneGeometry table will be extended  by EEA in the reference/legacy data flow with a 'Country' attribute. However, another, gridded version of the zones will be generated in there - ZoneGeometryGrid, which will contain gridded AQ values in 2 layers: 
- 1 Very High Resolution layer (100m) for populated areas, 
- 1 High Resolution layer (1000m) for all areas. 

ZoneGeometryGrid will be extended by EEA with the following attributes:
- CountryCode;
- ZoneId;
- X, Y coordinates (SRID 3035);
- Grid number identifiers based on X and Y coordinates.

## Data management rules

It is recommended to report the ZoneGeometry table only for new zone geometries.

Zone geometries should be reported as geojson with SRID identifier and only the spatial data type "multipolygon" can be used. 
Expected projections are: 
- SRID3035, 
- SRID4258 or 
- SRID4326 (the only allowed for the French overseas areas).

Records in the ZoneGeometry table (and subsequently in ZoneGeometryGrid) which do not have any correspondence to records in the AssessmentRegimeZone table will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| ZGE_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| ZGE_02 | ZoneId | varchar(20) | string | PK |  | [AssessmentRegimeZone](AssessmentRegimeZone.md) |
| ZGE_03 | ZoneGeometryGeoJson | varbinary | geometry |  |  |  |

## Attribute details

### ZGE_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ZoneGeometry.html#zge-01-countrycode)
**Content**

Country or territory ISO2 code.

### ZGE_02 – ZoneId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ZoneGeometry.html#zge-02-zoneid)
**Content**

Identifier of the air quality zone, given by data provider.

### ZGE_03 – ZoneGeometryGeoJson


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ZoneGeometry.html#zge-03-zonegeometrygeojson)
**Content**

Geospatial representation of the air quality zone (e.g. polygon geometry).

**Remarks**

It is allowed to report zone geometries in coordinate systems with the following EPSG codes:
- 3035,
- 4258,
- 4326.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
ZGE_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
ZGE_02 | ZoneId | ZON_DU000A | varchar(20) | string | ✓ | 
ZGE_03 | ZoneGeometryGeoJson | {"type":"Feature","geometry":{"type":"MultiPolygon","coordinates":[[[[4.419074,51.3040095],[4.4181004999999995,51.305457],...,[4.3362534,51.1730749],[4.3367638,51.1732234]]]]},"properties":{"srid":"4326"}} | varbinary | geometry |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `ZoneGeometry`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)





