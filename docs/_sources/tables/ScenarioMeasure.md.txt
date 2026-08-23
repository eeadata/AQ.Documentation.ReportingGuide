# ScenarioMeasure

```{image} ../_static/table-icons/ScenarioMeasure.png
:alt: ScenarioMeasure
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the ScenarioMeasures table is to define the group(s) of measures (MeasureGroupId) associated to a scenario, as well as the total (by group of measures) reduction of pollution level which can be expected. It also points to model/OBE which was used for generating the results for the group of measures.

ScenarioMeasure (record) table has to be reported whenever a new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode, ScenarioId, MeasureGroupId and ScenarioCategory.

Updates of the ScenarioMeasure table will not be time stamped, i.e. each update generates the only version of the ScenarioMeasure that is stored at the EEA:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against PlanScenario table and Measure table, it may be cross-checking against the ModelObjectiveEstimation table.

There are no valid modifications of existing record in this table.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

ScenarioMeasure table will be extended by several attributes:

- Country (for convenience), based on ISO2 country codes,
- PollutantId (for convenience), from PlanScenario for the corresponding ScenarioId,
- Pollutant (for convenience), based on code list,
- DataAggregationProcessId, (for convenience), from PlanScenario for the corresponding ScenarioId,
- DataAggregationProcess, (for convenience) based on DataAggregationProcessId.

## Data management rules

MeasureGroupId allows reporting of impacts for group of measures e.g. originating from different national, regional or local level plans. In such case - MeasureReductionAssessmentMethodId may be used for pointing to AssessmentMethodId in the ModelObjectiveEstimation table for definition of the modelling/OBE method which generated the scenario values for each measure group.
In case the MeasureReductionAssessmentMethodId is reported - it must be different for each ScenarioId, ScenarioCategory and MeasureGroupId so that it is possible to report values for each of them in the MOEResult tables.
Also, one of the MOEResult tables must be populated for each reported MeasureReductionAssessmentMethodId but the results may be provided just for the grid cells corresponding to the sampling point locations.

There is no need to report records for 'reference' scenario category in ScenarioMeasure table.

If MeasureGroupPollutionReduction is reported - the sum for specific scenario category within ScenarioId must be =< the difference between the values of ScenarioPollutionLevel reported for 'reference' and that ScenarioId and ScenarioCategory in PlanScenario table.
It is not allowed to re-use MeasureGroupId in different ScenarioId (to avoid complications in deletion procedures).

Records in ScenarioMeasure table which do not have any correspondence to records in PlanScenario table or Measure table will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| SME_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| SME_02 | ScenarioId | varchar(50) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[PlanScenario](PlanScenario.md) |
| SME_03 | ScenarioCategory | varchar(20) | string | PK | [scenariocategory](https://dd.eionet.europa.eu/vocabulary/aq/scenariocategory) |  |
| SME_04 | MeasureGroupId | varchar(50) | string | PK |  | [MeasurementStation](MeasurementStation.md) |
| SME_05 | MeasureGroupPollutionReduction | decimal(10,2) | numeric |  |  |  |
| SME_06 | MeasureReductionAssessmentMethodId | varchar(50) | string |  |  | [ModelObjectiveEstimation](ModelObjectiveEstimation.md) |

## Attribute details

### SME_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ScenarioMeasure.html#sme-01-countrycode)
**Content**

Country or territory ISO2 code.

### SME_02 – ScenarioId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ScenarioMeasure.html#sme-02-scenarioid)
**Content**

Identifier of the scenario, given by data provider.

**Remarks**

It will be cross-checked against PlanScenario table.

### SME_03 – ScenarioCategory


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ScenarioMeasure.html#sme-03-scenariocategory)
**Content**

Classification of the scenario (e.g., baseline, projection).

**Remarks**

ScenarioCategory: baseline or projection. It should be included in the composite PK in the next iteration of schema version.

### SME_04 – MeasureGroupId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ScenarioMeasure.html#sme-04-measuregroupid)
**Content**

Identifier of the pollution reduction for measure group, given by data provider.

**Remarks**

MeasureGroupId: distinct groups might contain one or more measures. For example, group 1 contains all the measures related to traffic, while group 2 contains all the measures related to industry. To the extreme, the group may correspond to one measure only; the same MeasureGroupId might be used for different scenarios, also - several MeasureGroupId might be declared for the same scenario.

It will be cross-checked against Measure table.

### SME_05 – MeasureGroupPollutionReduction


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ScenarioMeasure.html#sme-05-measuregrouppollutionreduction)
**Content**

Reduction in air pollution concentration levels due to the applied group of measures.

**Remarks**

Sum of MeasureGroupAirPollutionReduction within ScenarioId should agree with the difference between value of AirPollutionLevel in the first AttainmentId and the value reported in PlanScenario as ScenarioAirPollutionLevel.

### SME_06 – MeasureReductionAssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ScenarioMeasure.html#sme-06-measurereductionassessmentmethodid)
**Content**

Identifier of the assessment method - model - used in the scenario, given by data provider.

**Remarks**

AssessmentMethodId: the model/OBE used for producing the results for the measure group (also to be declared in the Model table). It may be cross-checked against Model table, also - indirectly - against ModellingResult table.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
SME_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
SME_02 | ScenarioId | SCE_ZON_DU000B_00005_LV_H_daysAbove | varchar(50) | string | ✓ | 
SME_03 | ScenarioCategory | baseline | varchar(20) | string | ✓ | ✓
SME_04 | MeasureGroupId | MG1_SCE_ZON_DU000B_00005_LV_H_daysAbove | varchar(50) | string | ✓ | 
SME_05 | MeasureGroupPollutionReduction | null | decimal(10,2) | numeric |  | 
SME_06 | MeasureReductionAssessmentMethodId | null | varchar(50) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `ScenarioMeasure`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
