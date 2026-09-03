# ModelObjectiveEstimation

```{image} ../_static/table-icons/ModelObjectiveEstimation.png
:alt: ModelObjectiveEstimation
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the ModelObjectiveEstimation table is to collect data on applications of modelling (MOD) or objective estimation (OBE) methodology. It describes the specific use of the model/OBE (assessments, adjustments, scenarios) and the way the modelling/OBE results are provided and should be interpreted (via ResultEncoding). It also includes information on MQI and the methodology itself through attached documentation.

ModelObjectiveEstimation (record) table has to be reported whenever a new information or an update of existing information is available.
Attributes which create unique identifier of each record: CountryCode, AssessmentMethodId and DataAggregationProcessId.

Updates of the ModelObjectiveEstimation table will not be time stamped - i.e. each update generates the only version of the table in reference/legacy data:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against code lists.

Valid modifications of existing record in this table are:
- attaching new/different documentation,
- minor corrections e.g. of wrong code list values or MQI value.
Validity of the modifications of existing record will be tested using QC (rules to be established).
Allowed modifications are not supposed to affect outcomes of compliance analysis and/or assessments.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

ModelObjectiveEstimation table will be extended  by EEA by several attributes:
- Country (for convenience), based on ISO2 country codes,
- Pollutant (for convenience), based on code list,
- DataAggregationProcess, based on DataAggregationProcessId.

## Data management rules

The ModelObjectiveEstimation table records may be kept relatively static, i.e. there is no need to report a new AssessmentMethodId every year if the model/OBE application does not change significantly. 

Details regarding annual quality indicators or input data can be provided with new documentation attached to the same document Ids (see more clarification below). 
It is up to the reporting authorities to decide if the reporting of data from models require new entry in the ModelObjectiveEstimation table. Good practice is to check if it is possible to report MOEResult (Inline or External) with the same AssessmentMethodId without getting a BLOCKER error - usually if this works, then it is fine to keep the same record in the ModelObjectiveEstimation table. 

The GenericMQI should be understood as MQI calculated for the reported model/OBE but not specific to the related results - e.g. MQI for models/OBE used for reporting adjustment (Saharan dust, etc.) or for reporting SRs (MQI would not necessarily reflect the uncertainty of the SR areas), or for reporting scenarios. 

For the purpose of reporting a single value for air quality zone (usually from OBE), ResultEncoding = 'zone' should be used. Since the value is already reported in ComplianceAssessmentMethod table, no corresponding records in MOEResultInline neither in MOEResultExternal will be expected in such case. 

It is recommended not to change ModelDocumentId or DataQualityDocumentId in case of documentation update related to the same modelling/OBE application. Instead,  a new attachment should be uploaded in Document table re-using the same DocumentId. Previous versions of documentation will be kept in reference data. In case when the same e.g. DataQualityDocumentId was used for all records and there is a need to modify documentation only for one specific model/OBE, it is recommended to create a new DataQualityDocumentId for that record in ModelObjectiveEstimation table, and then report old (not model/OBE specific) and new (model/OBE specific) documents as attachments for that new DataQualityDocumentId (as DocumentId) in the Document table in a subsequent manner. 

Records in ModelObjectiveEstimation table that do not have references in other tables and do not have any valid values in MOEResultInline nor in MOEResultExternal will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| MOE_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| MOE_02 | AssessmentMethodId | varchar(100) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[SpatialRepresentativeness](SpatialRepresentativeness.md)<br>[PollutionLevelAdjustment](PollutionLevelAdjustment.md)<br>[PlanScenario](PlanScenario.md)<br>[MOEResultInline](MOEResultInline.md)<br>[MOEResultExternal](MOEResultExternal.md) |
| MOE_03 | DataAggregationProcessId | varchar(50) | string | PK | [aggregationprocess](https://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/view) | [MOEResultInline](MOEResultInline.md)<br>[MOEResultExternal](MOEResultExternal.md) |
| MOE_04 | AssessmentMethodName | varchar(150) | string |  |  |  |
| MOE_05 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| MOE_06 | ResultEncoding | varchar(10) | string |  | [resultencoding](https://dd.eionet.europa.eu/vocabulary/aq/resultencoding) |  |
| MOE_07 | MethodApplication | varchar(20) | string |  | [modelapplication](https://dd.eionet.europa.eu/vocabulary/aq/modelapplication) |  |
| MOE_08 | GenericMQI | decimal(5,2) | numeric |  |  |  |
| MOE_09 | DataQualityDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |
| MOE_10 | MethodDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |

## Attribute details

### MOE_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-01-countrycode)
**Content**

Country or territory ISO2 code.

---

### MOE_02 – AssessmentMethodId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-02-assessmentmethodid)
**Content**

Identifier of the assessment method (model), given by data provider.

**Remarks**

AssessmentMethodId which is model or OBE identifier is understood as an application of modelling or estimation methodology.
It may be re-used for different years if the methodology and data sources remain the same (for example when the same source of meteorological data is used with data from different years).

---

### MOE_03 – DataAggregationProcessId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-03-dataaggregationprocessid)
**Content**

Identifier for the process of data aggregation into statistical values.

**Remarks**

Several different statistics may be generated by the same AssessmentMethodId (for example where time series are modelled and subsequently aggregated).

---

### MOE_04 – AssessmentMethodName


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-04-assessmentmethodname)
**Content**

Name of model or OBE which can be re-used with different AssessmentMethodId values.

**Remarks**

Examples include model names such as 'CHIMERE', 'WRF-Chem', etc.

---

### MOE_05 – PollutantId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-05-pollutantid)
**Content**

Code of the air pollutant being measured, as per Data Dictionary standards.

**Remarks**

Only one pollutant can be handled by a single AssessmentMethodId (model/OBE).

---

### MOE_06 – ResultEncoding


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-06-resultencoding)
**Content**

Encoding method used for model results.

**Remarks**

Allowed values include:
- zone
- inline
- external

---

### MOE_07 – MethodApplication


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-07-methodapplication)
**Content**

Purpose of the model application.

Examples include:
- assessment
- adjustment
- scenario
- spatial representativeness

**Remarks**

The same Model/OBE identifier can only have one MethodApplication.

---

### MOE_08 – GenericMQI


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-08-genericmqi)
**Content**

Modelling Quality Indicator.

**Remarks**

MQI is reported here because it may originate from model or OBE validation exercises not directly related to the area for which modelling results are submitted within AQ e-Reporting.
It is considered general information describing the quality of the modelling application used in the reporting.

---

### MOE_09 – DataQualityDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-09-dataqualitydocumentid)
**Content**

Identifier of the report describing the model, given by the data provider.

---

### MOE_10 – MethodDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/ModelObjectiveEstimation.html#moe-10-methoddocumentid)
**Content**

Identifier of the report detailing the quality of the modelled data, given by the data provider.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
MOE_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
MOE_02 | AssessmentMethodId | MOD_DU_NO2 | varchar(100) | string | ✓ | 
MOE_03 | DataAggregationProcessId | P1Y | varchar(50) | string | ✓ | ✓
MOE_04 | AssessmentMethodName | null | varchar(150) | string |  | 
MOE_05 | PollutantId | 8 | int | numeric |  | ✓
MOE_06 | ResultEncoding | external | varchar(10) | string |  | ✓
MOE_07 | MethodApplication | assessment | varchar(20) | string |  | ✓
MOE_08 | GenericMQI | 0.8 | decimal(5,2) | numeric |  | 
MOE_09 | DataQualityDocumentId | DOC_MOD_DQ_MOD_DU_NO2 | varchar(150) | string |  | 
MOE_10 | MethodDocumentId | DOC_MOD_MR_MOD_DU_NO2 | varchar(150) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `ModelObjectiveEstimation`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
