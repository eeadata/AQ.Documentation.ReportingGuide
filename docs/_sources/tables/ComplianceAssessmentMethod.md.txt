# ComplianceAssessmentMethod

```{image} ../_static/table-icons/ComplianceAssessmentMethod.png
:alt: ComplianceAssessmentMethod
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the ComplianceAssessmentMethod table is to collect information about assessment regimes and compliance situations on assessment method level. It specifies measured and/or modelled air quality values, aggregated in the context of the assessment regimes and allowed limits, provides uncertainty estimations for these values, describes some additional features of the air quality values (such as 'hotspot' and 'correction flag'), links to spatial representativeness areas (for sampling points and possibly - exceedance values) and gives preliminary description of reason for exceedance (based on code listed values) if such occurs.

ComplianceAssessmentMethod table has to be reported every year.
Attributes which create unique identifier of each record: CountryCode, ReportingYear, AssessmentRegimeId, AssessmentMethodId and DataAggregationProcessId.

Updates of the ComplianceAssessmentMethod table will not be time stamped, i.e. each update generates the only version of the compliance situation that is stored at the EEA:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against aggregation code list, existing records in ModelObjectiveEstimation table, SamplingPoint table, SpatialRepresentativeness table and AssessmentRegimeZone table, as well as - indirectly - against ObservationMeasurementResult and MOEResult tables.

Valid modifications of existing record: beside the attributes which create unique identifier, AttainmentId, PollutantId and SRSId, modifications of value are in principle allowed for all other attributes. However, the degree of freedom for such modifications will be different, depending on data type and impact of modification, e.g.:
- CorrectionFlag, Hotspot - all changes may be allowed,
- Uncertainties - changes within certain numeric ranges,
- PollutionLevel(s) - must agree with EEA's aggregations,
- PreliminaryReason - all changes may be allowed within AttainmentId, but split into more compliance situation (> 1 of AttainmentId) will require additional rules (impact on PollutionLevelAdjustment, CompliancePlanLink), etc.

Validity of the modifications of existing record will be tested using QC (rules to be established).
Allowed modifications may affect outcomes of compliance analysis and/or assessments, therefore re-submissions for past years, for which compliance reporting has been already done, will require additional tests vs reference/legacy data before official release of such data is granted.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

ComplianceAssessmentMethod table will be extended by EEA by several attributes:
- Country (for convenience), based on ISO2 country codes,
- Pollutant (for convenience), based on code list,
- DataAggregationProcess, based on DataAggregationProcessId,
- EEAAdjustmentEstimation, based on EEA's processing of information included in the PollutionLevelAdjustment table,
- EEAExceedanceAssessment, based on EEAAdjustmentEstimation and allowed limit values,
- EEAMQIestimation, based on EEA's interpretation of MOEResults vs. ObservationMeasurementResult.

## Data management rules

In case of reporting AEI, one record for each relevant AssessmentRegimeId should be reported, specifying the value of AEI under PollutionLevel attribute and an OBE method identifier under AssessmentMethodId. OBE method (averaging across territorial unit) should be described in ModelObjectiveEstimation table with ResultEncoding 'zone'.

The values related to the new environmental objectives should be reported from the beginning of the new reporting in ReportNet3. Exceedances of the new thresholds should be indicated via IsExceedance attribute in the same way as exceedances of the currently used threshold values. They cannot and will not be handled as legally binding exceedances, i.e. will not determine compliance status of zones but they will be used for identification of needs for the roadmaps.

Deletion of an existing record is possible via the Deletion attribute (by reporting value = 1).

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| CAM_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| CAM_02 | ReportingYear | int | numeric | PK |  |  |
| CAM_03 | AssessmentRegimeId | varchar(50) | string | PK |  | [AssessmentRegimeZone](AssessmentRegimeZone.md) |
| CAM_04 | DataAggregationProcessId | varchar(50) | string | PK | [aggregationprocess](https://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/view) |  |
| CAM_05 | AssessmentMethodId | varchar(50) | string | PK |  | [SamplingPoint](SamplingPoint.md)<br>[SamplingProcess](SamplingProcess.md)<br>[SamplingPointLocation](SamplingPointLocation.md)<br>[ObservationMeasurementResult](ObservationMeasurementResult.md)<br>[ModelObjectiveEstimation](ModelObjectiveEstimation.md)<br>[MOEResultInline](MOEResultInline.md)<br>[MOEResultExternal](MOEResultExternal.md) |
| CAM_06 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| CAM_07 | AssessmentType | varchar(50) | string |  | [assessmenttype](https://dd.eionet.europa.eu/vocabulary/aq/assessmenttype/view) |  |
| CAM_08 | IsExceedance | varchar(5) | string |  |  |  |
| CAM_09 | DataCoverage | decimal(5,2) | numeric |  |  |  |
| CAM_10 | PollutionLevel | decimal(10,3) | numeric |  |  |  |
| CAM_11 | PollutionLevelAdjusted | decimal(10,3) | numeric |  |  |  |
| CAM_12 | RelativeUncertaintyLimit | decimal(10,2) | numeric |  |  |  |
| CAM_13 | AssessmentMQI | decimal(5,2) | numeric |  |  |  |
| CAM_14 | CorrectionFlag | bit | boolean |  |  |  |
| CAM_15 | AttainmentId | varchar(50) | string |  |  | [CompliancePlanLink](CompliancePlanLink.md)<br>[PollutionLevelAdjustment](PollutionLevelAdjustment.md) |
| CAM_16 | SRSId | varchar(50) | string |  |  | [SpatialRepresentativeness](SpatialRepresentativeness.md) |
| CAM_17 | PreliminaryReason | varchar(50) | string |  | [exceedancereason](https://dd.eionet.europa.eu/vocabulary/aq/exceedancereason/view) |  |
| CAM_18 | Deletion | bit | boolean |  |  |  |

## Attribute details

### CAM_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-01-countrycode)
**Content**

Country or territory ISO2 code.

### CAM_02 – ReportingYear


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-02-reportingyear)
**Content**

Year for which the data has been reported.

### CAM_03 – AssessmentRegimeId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-03-assessmentregimeid)
**Content**

Identifier of the air quality assessment regime, given by data provider.

**Remarks**

It will be cross-checked against the AssessmentRegimeZone table.

### CAM_04 – DataAggregationProcessId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-04-dataaggregationprocessid)
**Content**

Identifier of the process used for aggregating air quality data into statistical values.

### CAM_05 – AssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-05-assessmentmethodid)
**Content**

Identifier of the assessment method used for air quality evaluation, given by data provider.

**Remarks**

Either SamplingPoint or Model/OBE, it will be cross-checked against the SamplingPoint table or the Model table, also - indirectly - against the ObservationMeasurementResult table and/or the ModellingResult tables.

### CAM_06 – PollutantId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-06-pollutantid)
**Content**

Code of the air pollutant for which the assessment is being conducted.

### CAM_07 – AssessmentType


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-07-assessmenttype)
**Content**

Classification of assessment methods into common types.

### CAM_08 – IsExceedance


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-08-isexceedance)
**Content**

Statement indicating whether pollution levels exceed environmental objectives.

### CAM_09 – DataCoverage


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-09-datacoverage)
**Content**

The proportion of the calendar year for which valid measurement data are available, expressed as a percentage.

**Remarks**

One element of DQO (see Directive 2024/2881 Section B.

### CAM_10 – PollutionLevel


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-10-pollutionlevel)
**Content**

Measured or modeled concentration level of the air pollutant.

**Remarks**

AirPollutionLevel must be reported for every AssessmentMethodId.

### CAM_11 – PollutionLevelAdjusted


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-11-pollutionleveladjusted)
**Content**

Adjusted concentration level of the air pollutant, accounting for specific corrections.

### CAM_12 – RelativeUncertaintyLimit


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-12-relativeuncertaintylimit)
**Content**

The maximum relative uncertaintyfor assessment method (given for measurement).

**Remarks**

RelativeUncertaintyLimit must be reported for every AssessmentMethodId which refer to sampling points.

### CAM_13 – AssessmentMQI


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-13-assessmentmqi)
**Content**

Modelling Quality Indicator

### CAM_14 – CorrectionFlag


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-14-correctionflag)
**Content**

Correction factor for measured values applied (Y/N)

**Remarks**

Y/N. Correction is a string/boolean to be used in order to certify that, in case the SamplingProcess is equivalent to the reference method, the values have been corrected adequately (e.g. PM but also ozone with the cross section).

### CAM_15 – AttainmentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-15-attainmentid)
**Content**

Identifier of the air quality compliance situation, given by data provider (preliminary reason level).

**Remarks**

AttainmentId distinguishes each compliance situation. If there is no exceedance in the zone/assessment regime, there will be only one AttainmentId. If exceedance occurs, if it is caused (most probably) by the same reason and its extent (delineated by sampling point SRAs or modelling results) covers the whole zone, there will be also only one AttainmentId. However, if single exceedance (caused by the same reason) does not cover the whole zone, there will be 2 AttainmentIds - one for the exceedance situation and one for the non-exceedance situation in the same zone/assessment regime. Also - if the exceedances in the same zone/assessment regime are caused by different reasons, there will be more than 1 AttainmentIds.

### CAM_16 – SRSId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-16-srsid)
**Content**

Identifier of the area representing spatial representativeness.

**Remarks**

Identifier linking to either SPO representativeness or to exceedance extent.

### CAM_17 – PreliminaryReason


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-17-preliminaryreason)
**Content**

Initial justification or reasoning for reported exceedance levels.

**Remarks**

This is crucial for distinguishing between different compliance situations in the same zone/assessment regime and pointing the relevant actions (air quality plans). It does not have to be precise at the first assessment of new exceedance and it can be changed from one year to another.

### CAM_18 – Deletion


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ComplianceAssessmentMethod.html#cam-18-deletion)
**Content**

Flag to indicate that this element and all related information must be deleted.

**Remarks**

Y/N

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
CAM_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
CAM_02 | ReportingYear | 2024 | int | numeric | ✓ | 
CAM_03 | AssessmentRegimeId | ARE_ZON_DU000A_0005_LV_H_aMean_2021_1 | varchar(50) | string | ✓ | 
CAM_04 | DataAggregationProcessId | P1Y | varchar(50) | string | ✓ | ✓
CAM_05 | AssessmentMethodId | SPO_DU0001_0005_100 | varchar(50) | string | ✓ | 
CAM_06 | PollutantId | 5 | int | numeric |  | ✓
CAM_07 | AssessmentType | fixed | varchar(50) | string |  | ✓
CAM_08 | IsExceedance | FALSE | varchar(5) | string |  | 
CAM_09 | DataCoverage | 85.78 | decimal(5,2) | numeric |  | 
CAM_10 | PollutionLevel | 21 | decimal(10,3) | numeric |  | 
CAM_11 | PollutionLevelAdjusted | null | decimal(10,3) | numeric |  | 
CAM_12 | RelativeUncertaintyLimit | 0.2 | decimal(10,2) | numeric |  | 
CAM_13 | AssessmentMQI | null | decimal(5,2) | numeric |  | 
CAM_14 | CorrectionFlag | Y | bit | boolean |  | 
CAM_15 | AttainmentId | ATT_ZON_DU000A_00005_LV_H_aMean_2024_1 | varchar(50) | string |  | 
CAM_16 | SRSId | SRS_ZON_DU000A_00005_1 | varchar(50) | string |  | 
CAM_17 | PreliminaryReason | null | varchar(50) | string |  | ✓
CAM_18 | Deletion | 0 | bit | boolean |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `ComplianceAssessmentMethod`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
