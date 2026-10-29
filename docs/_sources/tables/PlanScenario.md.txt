# PlanScenario

```{image} ../_static/table-icons/PlanScenario.png
:alt: PlanScenario
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the PlanScenario table is to provide information on the plan and on the scenario associated to the plan. It is the way of reporting combined impact of measures (which could originate from different plans - e.g. on national, regional and local levels) on a specific compliance situation (which may consist of several AttainmentIds - describing evolution over time in one or many locations). It specifies plan category (plan, roadmap, short-term) and core information regarding scenarios such as: category (reference, baseline, mitigation), year, projected air pollution levels, and model/OBE which was used for generating the scenario. It also gives further details about the plan and scenarios through attached documentation.

PlanScenario (record) table has to be reported whenever a new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode, PlanId, ScenarioId and ScenarioCategory.

Updates of the PlanScenario table will not be time stamped i.e. each update generates the only version of the PlanScenario that is stored at the EEA:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.

Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against relevant code lists, it may be cross-checking against the Model table.

Valid modifications of existing record in this table are:
- almost all allowed (apart from ScenarioAssessmentMethodId which must agree with AssessmentMethodId in ModelObjectiveEstimation table) within the scope of the code lists and their potential interconnections.

Validity of the modifications of existing record will be tested using QC (rules to be established).
Allowed modifications may affect outcomes of scenario analysis and/or assessments of measures, therefore re-submissions for past years, for which plans reporting has been already done, will require additional tests vs reference/legacy data before official release of such data is granted.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

PlanScenario table will be extended by several attributes:
- Country (for convenience), based on ISO2 country codes,
- Pollutant (for convenience), based on code list,
- DataAggregationProcess, based on DataAggregationProcessId,
- EEAExposedPopulation, based on EEA's estimation of population exposed to exceedance in scenario year.

## Data management rules

ScenarioAssessmentMethodId must be used for pointing to AssessmentMethodId in the ModelObjectiveEstimation table for definition of the modelling/OBE method which generated the scenario values. ScenarioAssessmentMethodId must be different for each ScenarioId and ScenarioCategory so that it is possible to report values for each of them in the MOEResult tables.
One of the MOEResult tables (inline or external) must be populated for each ScenarioAssessmentMethodId but the results may be reported just for the grid cells corresponding to the sampling point locations.

It is expected that modelling will be used for delineation of exceedance extents, including the 'reference' scenario category. However, if exceedance was reported based on sampling point measurements, the values reported in MOEResult tables for the 'reference' scenario should equal the measured values in the grid cells corresponding to the sampling point locations.
ScenarioAirPollutionLevel must agree with the maximum value reported in MOEResult tables under model/OBE declared as ScenarioAssessmentMethodId.

Records in PlanScenario table which do not have any correspondence to records in CompliancePlanLink table or ScenarioMeasure table will be flagged for deletion in the reference data flow.

Keep in mind that authorities responsible for establishing plans and for reporting the plans to the EU should be reported using Authority table.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| PSC_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| PSC_02 | PlanId | varchar(100) | string | PK |  | [CompliancePlanLink](CompliancePlanLink.md) |
| PSC_03 | ScenarioId | varchar(100) | string | PK |  | [CompliancePlanLink](CompliancePlanLink.md)<br>[ScenarioMeasure](ScenarioMeasure.md) |
| PSC_04 | ScenarioCategory | varchar(20) | string | PK | [scenariocategory](https://dd.eionet.europa.eu/vocabulary/aq/scenariocategory) |  |
| PSC_05 | ScenarioNationalCode | varchar(100) | string |  |  |  |
| PSC_06 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| PSC_07 | DataAggregationProcessId | varchar(50) | string |  | [aggregationprocess](https://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/view) |  |
| PSC_08 | ScenarioYear | int | numeric |  |  |  |
| PSC_09 | ScenarioAirPollutionLevel | decimal(10,3) | numeric |  |  |  |
| PSC_10 | ExposedPopulation | int | numeric |  |  |  |
| PSC_11 | ScenarioAssessmentMethodId | varchar(100) | string |  |  | [ModelObjectiveEstimation](ModelObjectiveEstimation.md) |

## Attribute details

### PSC_01 – CountryCode


**Content**

Country or territory ISO2 code.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-01-countrycode)

### PSC_02 – PlanId


**Content**

Identifier of the air quality plan, given by data provider.
This attribute must follow a defined structure (see Identifiers section). 

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-02-planid)

### PSC_03 – ScenarioId


**Content**

Identifier of the scenario, given by data provider.
This attribute must follow a defined structure (see Identifiers section). 

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-03-scenarioid)

### PSC_04 – ScenarioCategory


**Content**

Classification of the scenario.

**Remarks**

ScenarioCategory: baseline, compliance, reference. It should be included in the composite PK in the next iteration of schema version.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-04-scenariocategory)

### PSC_05 – ScenarioNationalCode


**Content**

Unique local code assigned to the evaluation scenario by the data provider.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-05-scenarionationalcode)

### PSC_06 – PollutantId


**Content**

Code of the air pollutant being considered in the scenario.

**Remarks**

AirPollutantCode: must correspond to the AirPollutantCode of the AttainmentId.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-06-pollutantid)

### PSC_07 – DataAggregationProcessId


**Content**

Identifier for the process used to aggregate air quality data in the scenario.

**Remarks**

DataAggregationProcessId: the data aggregation used for the scenario; it must correspond to the DataAggregationProcessId of the AttainmentId.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-07-dataaggregationprocessid)

### PSC_08 – ScenarioYear


**Content**

The calendar year for which the scenario has been modeled.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-08-scenarioyear)

### PSC_09 – ScenarioAirPollutionLevel


**Content**

Estimated air pollution level in the scenario year.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-09-scenarioairpollutionlevel)

### PSC_10 – ExposedPopulation


**Content**

### PSC_11 – ScenarioAssessmentMethodId


**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-11-scenarioassessmentmethodid)
**Content**

Identifier of the assessment method - model - used in the scenario, given by data provider.

**Remarks**

AssessmentMethodId: the model/OBE used for producing the scenario (also to be declared in the ModelObjectiveEstimation table). It may be cross-checked against Model table, also - indirectly - against ModellingResult table.

**In Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/PlanScenario.html#psc-10-exposedpopulation)

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
PSC_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
PSC_02 | PlanId | PLA_ZON_DU000B_00005_LV_H_daysAbove | varchar(100) | string | ✓ | 
PSC_03 | ScenarioId | SCE_ZON_DU000B_00005_LV_H_daysAbove | varchar(100) | string | ✓ | 
PSC_04 | ScenarioCategory | reference | varchar(20) | string | ✓ | ✓
PSC_05 | ScenarioNationalCode | PLA_another_scenario | varchar(100) | string |  | 
PSC_06 | PollutantId | 5 | int | numeric |  | ✓
PSC_07 | DataAggregationProcessId | P1Y-daysAbove50 | varchar(50) | string |  | ✓
PSC_08 | ScenarioYear | 2024 | int | numeric |  | 
PSC_09 | ScenarioAirPollutionLevel | 43 | decimal(10,3) | numeric |  | 
PSC_10 | ExposedPopulation | 95250 | int | numeric |  | 
PSC_11 | ScenarioAssessmentMethodId | MOD_DU_PM10_LOC_SCEN_REF | varchar(100) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

<!--
The complete set of examples is available in the Excel workbook, worksheet `SamplingPoint`.
-->

> **Note:** The example file is temporarily unavailable while it is being updated. The updated version will be made available once the revision is complete.

<!--
<a href="../_static/R3_v501_AQ_Reporting_guide_example.xlsx" target="_blank" rel="noopener noreferrer">Open complete examples workbook</a>
-->