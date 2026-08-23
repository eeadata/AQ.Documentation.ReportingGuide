# CompliancePlanLink

```{image} ../_static/table-icons/CompliancePlanLink.png
:alt: CompliancePlanLink
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the CompliancePlanLink table is to ensure the link between the AttainmentId as reported in the ComplianceAssessmentMethod table with the plan developed to tackle the exceedance (with source apportionment and relevant scenario).

CompliancePlanLink table has to be reported every year to maintaint the link between exceedance situations (evolving through years) and the relevant plans.
Attributes which create unique identifier of each record: CountryCode, AttainmentId, PlanId, ScenarioId and SourceApportionmentId.

Updates of the CompliancePlanLink table will not be time stamped, i.e. each update generates the only version of the CompliancePlanLink that is stored at the EEA. Since all the attributes create unique identifier of each record, the only update possible for this table is addition of a new record.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against existing records in ComplianceAssessmentMethod table, PlanScenario table and SourceApportionment table.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

CompliancePlanLink table will be extended by:
- Country (for convenience), based on ISO2 country codes,
- ReportingYear (for convenience), based on ComplianceAssessmentMethod (year of AttainmentId).

## Data management rules

All AttainmentIds which refer to exceedance indicated in ComplianceAssessmentMethod must be covered by plan developed to tackle the exceedance (with source apportionment and relevant scenario).
There can be only one unique combination of PlanId, ScenarioId and SourceApportionmentId for each AttainmentId. However, there can be many AttainmentIds (describing either one or many compliance situations evolving across years) for each unique combination of PlanId, ScenarioId and SourceApportionmentId.

It is recommended not to change PlanDocumentId in case of documentation update related to the same plan/scenario. Instead, a new attachment should be uploaded in Document table re-using the same DocumentId. Previous versions of documentation will be kept in reference data.
In case when the same PlanDocumentId was used for all records and there is a need to modify documentation e.g. only for one specific scenario, it is recommended to create a new PlanDocumentId for that record in CompliancePlanLink table, and then report old (plan specific) and new (e.g. scenario specific) documents as attachments for that new PlandocumentId (as DocumentId) in the Document table in a subsequent manner.

Records in CompliancePlanLink table which do not have any correspondence to records in ComplianceAssessmentMethods table will be flagged for deletion in the reference data flow.

Deletion of an existing record will be also possible via the Deletion attribute (by reporting value = 1).

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| CPL_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| CPL_02 | AttainmentId | varchar(50) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md) |
| CPL_03 | PlanId | varchar(50) | string | PK |  | [PlanScenario](PlanScenario.md) |
| CPL_04 | ScenarioId | varchar(50) | string | PK |  | [PlanScenario](PlanScenario.md) |
| CPL_05 | SourceApportionmentId | varchar(50) | string | PK |  | [SourceApportionment](SourceApportionment.md) |
| CPL_06 | PlanCategory | varchar(20) | string |  | [plancategory](https://dd.eionet.europa.eu/vocabulary/aq/plancategory/view) |  |
| CPL_07 | PlanTitle | nvarchar(1000) | string |  |  |  |
| CPL_08 | PlanAdoptionDate | date | datetime |  |  |  |
| CPL_09 | PlanBeginDate | date | datetime |  |  |  |
| CPL_10 | PlanEndDate | date | datetime |  |  |  |
| CPL_11 | PlanDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |
| CPL_12 | Deletion | bit | boolean |  |  |  |

## Attribute details

### CPL_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/CompliancePlanLink.html#cpl-01-countrycode)
**Content**

Country or territory ISO2 code.

### CPL_02 – AttainmentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/CompliancePlanLink.html#cpl-02-attainmentid)
**Content**

Identifier of the air quality compliance situation, given by data provider.

**Remarks**

Several AttainmentIds can point to the same PlanId (e.g. the plan covers different pollutants or successive years of exceedance for the same pollutant). Alternatively, there might be several plans applying to the same AttainmentId (e.g. different authority level, or successive plans). It will be cross-checked against the ComplianceAssessmentMethod table.

### CPL_03 – PlanId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/CompliancePlanLink.html#cpl-03-planid)
**Content**

Identifier of the air quality plan, given by data provider.

**Remarks**

It will be cross-checked against the PlanScenario table.

### CPL_04 – ScenarioId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/CompliancePlanLink.html#cpl-04-scenarioid)
**Content**

Identifier of the scenario, given by data provider.

**Remarks**

ScenarioId, several scenarios can apply to the same PlanId (e.g. different pollutant and/or data aggregation) and vice versa. It will be cross-checked against the PlanScenario table.

### CPL_05 – SourceApportionmentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/CompliancePlanLink.html#cpl-05-sourceapportionmentid)
**Content**

Identifier of the source apportionment, given by data provider.

**Remarks**

SourceApportionmentId, there might be only one SourceApportionment per ScenarioId but several per PlanId (e.g.: different pollutant and/or data aggregation). It will be cross-checked against the SourceApportionment table.

### CPL_06 – PlanCategory

**Content**

Category of the air quality plan (e.g., roadmap, short-term plan, plan).

**Remarks**

PlanCategory: corresponds to the different type of plan considered under the recasted Air Quality Directive 2024/2881 – roadmap, short-term plan, plan.

### CPL_07 – PlanTitle

**Content**

Title of the plan

**Remarks**

PlanTitle can be reported in any of the EU languages.

### CPL_08 – PlanAdoptionDate

**Content**

Date of official adoption of the plan by the responsible authorities

### CPL_09 – PlanBeginDate

**Content**

Start date (enforcement date) for the plan

**Remarks**

Begin/End date refers to the validity period of the plan/roadmap, i.e. when it enters into force and until it's unvalid. Note that some plans might not have an end date. In such cases PlanEndDate should be NULL.

### CPL_10 – PlanEndDate

**Content**

End date for the plan

**Remarks**

Begin/End date refers to the validity period of the plan/roadmap, i.e. when it enters into force and until it's unvalid. Note that some plans might not have an end date. In such cases PlanEndDate should be NULL.

### CPL_11 – PlanDocumentId

**Content**

Identifier of the air quality plan document given by data provider.

### CPL_12 – Deletion


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/CompliancePlanLink.html#cpl-12-deletion)
**Content**

Flag to indicate that this element must be deleted

**Remarks**

Y/N

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
CPL_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
CPL_02 | AttainmentId | ATT_ZON_DU000B_00005_LV_H_daysAbove_2024_1 | varchar(50) | string | ✓ | 
CPL_03 | PlanId | PLA_ZON_DU000B_00005_LV_H_daysAbove | varchar(50) | string | ✓ | 
CPL_04 | ScenarioId | SCE_ZON_DU000B_00005_LV_H_daysAbove_1 | varchar(50) | string | ✓ | 
CPL_05 | SourceApportionmentId | SAP_ZON_DU000B_00005_LV_H_daysAbove | varchar(50) | string | ✓ | 
CPL_06 | PlanCategory | plan | varchar(20) | string |  | ✓
CPL_07 | PlanTitle | აირე კალიტატე პროგрама გენერალა, კლიმა ბაბეს ე ემისა ულიე პლანა პორ ურბა-იუგ დუსტოვა რეჟიონ, მე ვეპრიმ პლანა, ტრეგუეს ე ნდიეკიე მეხანიზამ 2028–2035 | nvarchar(1000) | string |  | 
CPL_08 | PlanAdoptionDate | 2025-11-28 | date | datetime |  | 
CPL_09 | PlanBeginDate | 2026-01-01 | date | datetime |  | 
CPL_10 | PlanEndDate | 2030-12-31 | date | datetime |  | 
CPL_11 | PlanDocumentId | DOC_ZON_DU000B_00005_LV_H_daysAbove | varchar(150) | string |  | 
CPL_12 | Deletion | 0 | bit | boolean |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `CompliancePlanLink`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
