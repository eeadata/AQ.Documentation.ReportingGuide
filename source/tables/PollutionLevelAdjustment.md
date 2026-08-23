# PollutionLevelAdjustment

```{image} ../_static/table-icons/PollutionLevelAdjustment.png
:alt: PollutionLevelAdjustment
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the PollutionLevelAdjustment table is to collect information on deductions (adjustments) due to natural sources or winter salting and sanding. It describes the adjustment source/type (using code listed values) as well as points to the method (model/OBE) used for the assessments.

PollutionLevelAdjustment (record) table has to be reported whenever a new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode, AttainmentId and AdjustmentSource.

Updates of the PollutionLevelAdjustment table will not be time stamped - i.e. each update generates the only version of the table in reference/legacy data:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against existing records in ModelObjectiveEstimation table and ComplianceAssessmentMethod table, as well as - indirectly - against MOEResult tables.

Valid modifications of existing record in this table are: minor corrections e.g. of wrong code list values.
Validity of the modifications of existing record will be tested using QC (rules to be established).
Allowed modifications are not supposed to directly affect outcomes of compliance analysis and/or assessments.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

PollutionLevelAdjustment table will be extended by:
- Country (for convenience), based on ISO2 country codes.

## Data management rules

AdjustmentAssessmentMethodId must be used for pointing to AssessmentMethodId in the ModelObjectiveEstimation table for definition of the modelling/OBE method which generated the adjustment values.

AdjustmentAssessmentMethodId must be different for each AdjustmentSource so that it is possible to report adjustment values for each of them in the MOEResult tables.

Records in PollutionLevelAdjustment table which do not have any correspondence to records in ComplianceAssessmentMethods table will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| ADJ_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| ADJ_02 | AttainmentId | varchar(50) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md) |
| ADJ_03 | AdjustmentSource | varchar(50) | string | PK | [adjustmentsourcetype](https://dd.eionet.europa.eu/vocabulary/aq/adjustmentsourcetype/view) |  |
| ADJ_04 | AdjustmentAssessmentMethodId | varchar(50) | string |  |  | [ModelObjectiveEstimation](ModelObjectiveEstimation.md) |
| ADJ_05 | AdjustmentDocumentId |  |  |  |  | [Documentation](Documentation.md) |

## Attribute details

### ADJ_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PollutionLevelAdjustment.html#adj-01-countrycode)
**Content**

Country or territory ISO2 code.

### ADJ_02 – AttainmentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PollutionLevelAdjustment.html#adj-02-attainmentid)
**Content**

Identifier of the air quality compliance situation, given by data provider.

**Remarks**

It will be cross-checked against the ComplianceAssessmentMethod table.

### ADJ_03 – AdjustmentSource


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PollutionLevelAdjustment.html#adj-03-adjustmentsource)
**Content**

Description of the source being adjusted (e.g., sea spray, volcanic activity).

### ADJ_04 – AdjustmentAssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PollutionLevelAdjustment.html#adj-04-adjustmentassessmentmethodid)
**Content**

Identifier of the method - model - used for deduction assessment, given by data provider.

**Remarks**

AdjAssessmentMethodId is a model or OBE identifier that points to the method (model/OBE in the Model table) which was used for the assessments of the deduction.
If there are several different adjustment types/sources, different AdjAssessmentMethodIds must be used, so that it is possible to distinguish between corresponding adjustment values reported in the ModellingResult (Inline or External) table.
It will be cross-checked against the Model table, also - indirectly - against the ModellingResult tables.

### ADJ_05 – AdjustmentDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PollutionLevelAdjustment.html#adj-05-adjustmentdocumentid)
## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
ADJ_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
ADJ_02 | AttainmentId | ATT_ZON_DU000B_00005_LV_H_aMean_2024_1 | varchar(50) | string | ✓ | 
ADJ_03 | AdjustmentSource | H | varchar(50) | string | ✓ | ✓
ADJ_04 | AdjustmentAssessmentMethodId | OBE_DU_SEASALT_PM10_H_LV_ADJ | varchar(50) | string |  | 
ADJ_05 | AdjustmentDocumentId | null |  |  |  | 

**Legend:** PK = Primary Key; FK = Foreign Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `PollutionLevelAdjustment`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
