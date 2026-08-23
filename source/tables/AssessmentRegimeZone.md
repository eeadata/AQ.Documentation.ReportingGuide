# AssessmentRegimeZone

```{image} ../_static/table-icons/AssessmentRegimeZone.png
:alt: AssessmentRegimeZone
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the AssessmentRegimeZone table is to collect information about air quality zones and related assessment regimes. It specifies zone details such as (geographical) name, area, code, category, type, population as well as zone level parameters of assessment regimes such as objective, target, pollutant, reporting metric, assessment threshold and characteristics of exemptions (postponement, SPO reduction).

AssessmentRegimeZone table has to be reported at least every 5 years or whenever a new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode and AssessmentRegimeId.

Updates of the AssessmentRegimeZone table will not be time stamped, i.e. each update generates the only version of the assessment regimes that is stored at the EEA:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against aggregation code list, existing records in Zone table, etc.

Valid modifications of existing record in this table are:
- correction of PostponementYear or FixedMeasurementReduction or AssessmentThresholdExceedance,
- minor corrections e.g. of ZoneName or ZoneNationalCode, ZoneResidentPopulation and ZoneResidentPopulationYear.
Validity of the modifications of existing record will be tested using QC (rules to be established).
Allowed modifications may affect outcomes of compliance analysis and/or assessments, therefore re-submissions for past years, for which compliance reporting has been already done, will require additional tests vs reference/legacy data before official release of such data is granted.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

AssessmentRegimeZone table will be extended by EEA by several attributes in the reference data flow:
- Country (for convenience), based on ISO2 country codes,
- Pollutant (for convenience), based on code list,
- DataAggregationProcess, based on DataAggregationProcessId,
- ReportingYear, based on the corresponding records in ComplianceAssessmentMethod,
- Required number of sampling points, based on the recasted Air Quality Directive 2024/2881,
- Reported number of sampling points and modelling applications, based on data reported in ComplianceAssessmentMethod table,
- SR areas coverage,
- Modelling results coverage,
- Assessment regime zone exceedance status,
- Exceedance extent coverage,
- Reported number of measures.

## Data management rules

It is recommended to report the AssessmentRegimeZone table only when a new classification is available (at least every 5 years).

If a NUTS region is used - the ZoneCategory should be reported as `nuts` and NUTS region id should be provided as ZoneId, geometry does not need to be reported.
If a combination of NUTS regions is used, the area should be reported in the same way as a zone, i.e. ZoneCategory should be reported as `aqzone`, ZoneId should be assigned (following the rule for ZoneIds) and the zone geometry must be provided.

In case of reporting territorial units for AEI, the NUTS regions or combination of NUTS region may be used.

The new environmental objectives should be reported from the beginning of the new reporting in ReportNet3, to cover the needs for roadmaps.

Records in AssessmentRegimeZone table which do not have any correspondence to records in ComplianceAssessmentMethods table will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| ARZ_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| ARZ_02 | AssessmentRegimeId | varchar(50) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md) |
| ARZ_03 | ZoneId | varchar(50) | string |  |  | [ZoneGeometry](ZoneGeometry.md) |
| ARZ_04 | ZoneNationalCode | varchar(50) | string |  |  |  |
| ARZ_05 | ZoneArea | decimal(10,2) | numeric |  |  |  |
| ARZ_06 | ZoneCategory | varchar(20) | string |  | [zonecategory](https://dd.eionet.europa.eu/vocabulary/aq/zonecategory/view) |  |
| ARZ_07 | ZoneType | varchar(20) | string |  | [zonetype](https://dd.eionet.europa.eu/vocabulary/aq/zonetype/view) |  |
| ARZ_08 | ZoneName | varchar(150) | string |  |  |  |
| ARZ_09 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| ARZ_10 | ProtectionTarget | varchar(50) | string |  | [protectiontarget](https://dd.eionet.europa.eu/vocabulary/aq/protectiontarget/view) |  |
| ARZ_11 | ObjectiveType | varchar(50) | string |  | [objectivetype](https://dd.eionet.europa.eu/vocabulary/aq/objectivetype/view) |  |
| ARZ_12 | ReportingMetric | varchar(50) | string |  | [reportingmetric](https://dd.eionet.europa.eu/vocabulary/aq/reportingmetric/view) |  |
| ARZ_13 | AssessmentThresholdExceedance | varchar(20) | string |  | [assessmentthresholdexceedance](https://dd.eionet.europa.eu/vocabulary/aq/assessmentthresholdexceedance/view) |  |
| ARZ_14 | PostponementYear | int | numeric |  |  |  |
| ARZ_15 | FixedMeasurementReduction | bit | boolean |  |  |  |
| ARZ_16 | ZoneResidentPopulationYear | int | numeric |  |  |  |
| ARZ_17 | ZoneResidentPopulation | int | numeric |  |  |  |
| ARZ_18 | ClassificationYear | int | numeric |  |  |  |
| ARZ_19 | ClassificationDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |

## Attribute details

### ARZ_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-01-countrycode)
**Content**

Country or territory ISO2 code.

### ARZ_02 – AssessmentRegimeId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-02-assessmentregimeid)
**Content**

Identifier of the air quality assessment regime, given by data provider.

### ARZ_03 – ZoneId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-03-zoneid)
**Content**

Identifier of the air quality zone, given by data provider.

**Remarks**

It will be cross-checked against the ZoneGeometry table.

### ARZ_04 – ZoneNationalCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-04-zonenationalcode)
**Content**

Unique identifier of the air quality zone, given by data provider.

### ARZ_05 – ZoneArea


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-05-zonearea)
**Content**

Total area of the air quality zone.

### ARZ_06 – ZoneCategory


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-06-zonecategory)
**Content**

Category of the air quality zone (aq zone or nuts) - new code list.

### ARZ_07 – ZoneType


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-07-zonetype)
**Content**

Type of air quality zone (e.g., agglomeration and non-agglomeration).

### ARZ_08 – ZoneName


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-08-zonename)
**Content**

Geographical name of the air quality zone.

### ARZ_09 – PollutantId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-09-pollutantid)
**Content**

Code of the air pollutant for which the assessment is being conducted.

### ARZ_10 – ProtectionTarget


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-10-protectiontarget)
**Content**

Protection target for air quality (e.g., human health, vegetation).

### ARZ_11 – ObjectiveType


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-11-objectivetype)
**Content**

Type of environmental objective related to air quality assessment.

### ARZ_12 – ReportingMetric


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-12-reportingmetric)
**Content**

Metric corresponding to the standard (objective type).

### ARZ_13 – AssessmentThresholdExceedance


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-13-assessmentthresholdexceedance)
**Content**

Status indicating whether an assessment threshold has been exceeded.

### ARZ_14 – PostponementYear


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-14-postponementyear)
**Content**

Year of postponement applied to the air quality zone, pollutant, target, objective and metric/aggregation.

**Remarks**

PostponementYear relates to the postponement of attainment deadline and exemption from the obligation to apply certain limit values foreseen in the recasted Air Quality Directive 2024/2881 art. 18.
Leaving this attribute blank will mean that no postponement does apply.

### ARZ_15 – FixedMeasurementReduction


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-15-fixedmeasurementreduction)
**Content**

Use of indicative measurements and/or modelling to reduce fixed measurement network.

**Remarks**

Y/N.

FixedSPOReduction relates to the reduction of the number of sampling points for fixed measurements, which may be reduced by up to 50% under certain conditions as foreseen in the recasted Air Quality Directive 2024/2881 art. 9 §3.

### ARZ_16 – ZoneResidentPopulationYear


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-16-zoneresidentpopulationyear)
**Content**

Reference year for the resident population data in the zone.

### ARZ_17 – ZoneResidentPopulation


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-17-zoneresidentpopulation)
**Content**

Number of people residing within the air quality zone.

### ARZ_18 – ClassificationYear


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-18-classificationyear)
**Content**

The year of the last classification of the pollution level in the zone.

### ARZ_19 – ClassificationDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/AssessmentRegimeZone.html#arz-19-classificationdocumentid)
**Content**

Identifier of the report detailing the classification procedure given by data provider.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
ARZ_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
ARZ_02 | AssessmentRegimeId | ARE_ZON_DU000A_0005_LV_H_aMean_2021_1 | varchar(50) | string | ✓ | 
ARZ_03 | ZoneId | ZON_DU000A | varchar(50) | string |  | 
ARZ_04 | ZoneNationalCode | DU000A | varchar(50) | string |  | 
ARZ_05 | ZoneArea | 442.31 | decimal(10,2) | numeric |  | 
ARZ_06 | ZoneCategory | zone | varchar(20) | string |  | ✓
ARZ_07 | ZoneType | agg | varchar(20) | string |  | ✓
ARZ_08 | ZoneName | EcoDome Heights | varchar(150) | string |  | 
ARZ_09 | PollutantId | 5 | int | numeric |  | ✓
ARZ_10 | ProtectionTarget | H | varchar(50) | string |  | ✓
ARZ_11 | ObjectiveType | LV | varchar(50) | string |  | ✓
ARZ_12 | ReportingMetric | aMean | varchar(50) | string |  | ✓
ARZ_13 | AssessmentThresholdExceedance | aboveUAT | varchar(20) | string |  | ✓
ARZ_14 | PostponementYear | null | int | numeric |  | 
ARZ_15 | FixedMeasurementReduction | N | bit | boolean |  | 
ARZ_16 | ZoneResidentPopulationYear | 2020 | int | numeric |  | 
ARZ_17 | ZoneResidentPopulation | 599159 | int | numeric |  | 
ARZ_18 | ClassificationYear | 2021 | int | numeric |  | 
ARZ_19 | ClassificationDocumentId | DOC_ARE_ZON_DU_2021 | varchar(150) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `AssessmentRegimeZone`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
