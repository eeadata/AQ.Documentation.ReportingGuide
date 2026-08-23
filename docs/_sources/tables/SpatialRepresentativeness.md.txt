# SpatialRepresentativeness

```{image} ../_static/table-icons/SpatialRepresentativeness.png
:alt: SpatialRepresentativeness
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the SpatialRepresentativeness table is to ensure the link between the coverage of the spatial representativeness area of a sampling point or exceedance extent, and the ComplianceAssessmentMethod table.
It can also point to the method (model/OBE) used for the assessment of the SPO representativeness or the exceedance extent.

SpatialRepresentativeness table has to be reported whenever a new information or an update of existing information is available (at least every 5 years for the SPO representativeness and for each sampling point declared for compliance assessments).
Attributes which create unique identifier of each record: CountryCode, SRSId and SRSApplicationId.

Updates of the SpatialRepresentativeness table will not be time stamped, i.e. each update generates the only version of the SpatialRepresentativeness that is stored at the EEA.
Validity of a new record or modification will be tested using QC (rules to be established) - e.g. cross checking against existing records in ComplianceAssessmentMethod table, SRSInline and/or SRSExternal tables.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported the most recently.

## EEA extensions

SpatialRepresentativeness table will be extended by EEA by:
- Country (for convenience), based on ISO2 country codes.

## Data management rules

It is allowed to reuse SRSId within the same AQ zone and across the years. However, it is strongly recommended to set a new SRSId in ComplianceAssessmentMethod table and new record in SpatialRepresentativeness table with SRSApplication = `exc_sr`, whenever a new exceedance is reported (also by model/OBE).
This practice enables reporting of exceedance extents after relevant plans are in place, without re-submitting records for ComplianceAssessmentMethod table (but simply by using the SRSId which is already there). SRSAssessmentMethodId can be used for pointing to AssessmentMethodId in the ModelObjectiveEstimation table for definition of the modelling/OBE method which generated the SR areas (either for sampling point or as exceedance extents).
It is expected that in case of exceedance extents, the value in RepresentativenessAssessmentMethodId will be the same as value in ScenarioAssessmentMethodId in PlanScenario record referring to the same AttainmentId (because it is the same model/OBE).

Records in SpatialRepresentativeness table which do not have any correspondence to records in ComplianceAssessmentMethods table will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| SRS_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| SRS_02 | SRSId | varchar(50) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md) |
| SRS_03 | SRSApplicationId | varchar(50) | string | PK |  | [SRSInline](SRSInline.md)<br>[SRSExternal](SRSExternal.md) |
| SRS_04 | SRSApplication | varchar(50) | string |  | [SRapplication](https://dd.eionet.europa.eu/vocabulary/aq/SRapplication) |  |
| SRS_05 | ResultEncoding | varchar(10) | string |  | [resultencoding](https://dd.eionet.europa.eu/vocabulary/aq/resultencoding/view) |  |
| SRS_06 | RepresentativenessAssessmentMethodId | varchar(50) | string |  |  | [ModelObjectiveEstimation](ModelObjectiveEstimation.md) |

## Attribute details

### SRS_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SpatialRepresentativeness.html#srs-01-countrycode)
**Content**

Country or territory ISO2 code.

### SRS_02 – SRSId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SpatialRepresentativeness.html#srs-02-srsid)
**Content**

Identifier of the area representing the sampling point’s measurement spatial coverage or the extent of the exceedance, given by data provider.

### SRS_03 – SRSApplicationId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SpatialRepresentativeness.html#srs-03-srsapplicationid)
**Content**

Identifier pointing to the specific spatial representativeness given by data provider.

**Remarks**

The same SRSId can have several SRSApplication_Id (e.g. one for the SPO representativeness area and one for the exceedance extent).

### SRS_04 – SRSApplication


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SpatialRepresentativeness.html#srs-04-srsapplication)
**Content**

Application of spatial representativeness (SPO representativeness or the exceedance extent).

**Remarks**

New code list (SPO representativeness area, exceedance extent area).

### SRS_05 – ResultEncoding


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SpatialRepresentativeness.html#srs-05-resultencoding)
**Content**

Encoding method used for model results (`internal` or `external`).

### SRS_06 – RepresentativenessAssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SpatialRepresentativeness.html#srs-06-representativenessassessmentmethodid)
**Content**

Identifier of the assessment method (model) used for defining the area (either representativeness or extent), given by data provider.

**Remarks**

AssessmentMethodId is a model or OBE identifier that points to the method (model/OBE in the Model table) which was used for the assessments of the SPO representativeness area or the exceedance extent.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
SRS_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
SRS_02 | SRSId | SRS_ZON_DU000A_00005_1 | varchar(50) | string | ✓ | 
SRS_03 | SRSApplicationId | SRS_SPO_DU0001_0005_100 | varchar(50) | string | ✓ | 
SRS_04 | SRSApplication | spo_sr | varchar(50) | string |  | ✓
SRS_05 | ResultEncoding | inline | varchar(10) | string |  | ✓
SRS_06 | RepresentativenessAssessmentMethodId | MOD_DU_PM10_NAT_SR | varchar(50) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `SpatialRepresentativeness`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
