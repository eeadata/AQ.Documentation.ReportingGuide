# SourceApportionment

```{image} ../_static/table-icons/SourceApportionment.png
:alt: SourceApportionment
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the SourceApportionment table is to report information on the sources contributing to air pollution exceedances. It describes the spatial scale of the contributions, their type (background, increment) as well as sector of origin.

SourceApportionment (record) table has to be reported whenever a new source apportionment has been done (new AttainmentId) or an update of existing information is available (existing AttainmentId).
Attributes which create unique identifier of each record: CountryId, SourceApportionmentId, ContributionType, SpatialScale and SourceSector.

Updates of the SourceApportionment table will not be time stamped, i.e. each update generates the only version of the SourceApportionment that is stored at the EEA:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against relevant code lists.

Valid modifications of existing record in this table are:
- all allowed within the scope of the code lists and their potential interconnections.
Validity of the modifications of existing record will be tested using QC (rules to be established - e.g. Contribution must be =< 100%).
Allowed modifications may affect outcomes of scenario analysis and/or assessments of measures, therefore re-submissions for past years, for which plans reporting has been already done, will require additional tests vs reference/legacy data before official release of such data is granted.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

SourceApportionment table will be extended by:

- Country (for convenience), based on ISO2 country codes;
- Pollutant (for convenience), based on code list.

## Data management rules

It is recommended not to change SourceApportionmentDocumentId in case of documentation update related to the same plan/scenario. Iinstead, a new attachment should be uploaded in Document table re-using the same DocumentId. Previous versions of documentation will be kept in reference data. In case when the same SourceApportionmentDocumentId was used for all records and there is a need to modify documentation only for one specific source apportionment, it is recommended to create a new SourceApportionmentDocumentId for that record in SourceApportionment table, and then report old (general) and new (source apportionment specific) documents as attachments for that new SourceApportionmentDocumentId (as DocumentId) in the Document table in a subsequent manner. 

Records in SourceApportionment table which do not have any correspondence to Plans and Scenarios in CompliancePlanLink table will be flagged for deletion in the reference data flow. However, it is also possible to set the records for deletion by reporting Contribution value as -1.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| SAP_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| SAP_02 | SourceApportionmentId | varchar(50) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md) |
| SAP_03 | ContributionType | varchar(20) | string | PK | [contributiontype](https://dd.eionet.europa.eu/vocabulary/aq/contributiontype/view) |  |
| SAP_04 | SpatialScale | varchar(50) | string | PK | [spatialscale](https://dd.eionet.europa.eu/vocabulary/aq/spatialscale) |  |
| SAP_05 | SourceSector | varchar(50) | string | PK | [aq/sourcesectors](https://dd.eionet.europa.eu/vocabulary/aq/sourcesectors) |  |
| SAP_06 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| SAP_07 | Contribution | decimal(8,2) | numeric |  |  |  |
| SAP_08 | SourceApportionmentDocumentId | varchar(150) | string |  |  | [Documentation](Documentation.md) |

## Attribute details

### SAP_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-01-countrycode)
**Content**

Country or territory ISO2 code.

### SAP_02 – SourceApportionmentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-02-sourceapportionmentid)
**Content**

Identifier of the source apportionment, given by data provider.

### SAP_03 – Contribution Type


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-03-contributiontype)
**Content**

Type of contribution (e.g. background, increment).

### SAP_04 – SpatialScale 


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-04-spatialscale)
**Content**

Geographical scope of the contribution (e.g., urban, local, regional, national).

### SAP_05 – SourceSector


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-05-sourcesector)
**Content**

The sector responsible for emissions (e.g., traffic, industry, residential heating).

### SAP_06 – PollutantId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-06-pollutantid)
**Content**

Code of the air pollutant for which the contribution is being assessed.

**Remarks**

AirPollutantCode: must correspond to the AirPollutantCode of the AttainmentId.

### SAP_07 – Contribution


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-07-contribution)
**Content**

Estimated contribution of the specified source sector to air pollution levels [%].

**Remarks**

The value is understood as applicable to AirPollutionLevel adjusted for natural sources. Therefore contributions should not include the natural sources, should be given as % and sum up to 100% within SourceAppId. 

### SAP_08 – SourceApportionmentDocumentId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/SourceApportionment.html#sap-08-sourceapportionmentdocumentid)
**Content**

Identifier of the documentation on source apportionment.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
SAP_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
SAP_02 | SourceApportionmentId | SAP_ZON_DU000B_00005_LV_H_daysAbove | varchar(50) | string | ✓ | 
SAP_03 | ContributionType | background | varchar(20) | string | ✓ | ✓
SAP_04 | SpatialScale | regional | varchar(50) | string | ✓ | ✓
SAP_05 | SourceSector | other | varchar(50) | string | ✓ | ✓
SAP_06 | PollutantId | 5 | int | numeric |  | ✓
SAP_07 | Contribution | 9 | decimal(8,2) | numeric |  | 
SAP_08 | SourceApportionmentDocumentId | DOC_SAP_ZON_DU000B_00005_LV_H_daysAbove | varchar(150) | string |  | 

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `SourceApportionment`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
