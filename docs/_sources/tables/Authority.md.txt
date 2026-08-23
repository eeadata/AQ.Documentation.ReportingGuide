# Authority

```{image} ../_static/table-icons/Authority.png
:alt: Authority
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the Authority table is to communicate the contact details of the responsible authorities. It describes the authorities and their area of responsibility (AuthorityRole).

Authority table has to be reported whenever new information or an update of existing information is available.

Attributes which create unique identifier of each record: CountryCode, AuthorityInstanceId, AuthorityRole and Email.

Updates of the Authority table will be managed using reference/legacy data, where each addition and modification will be stamped with ReportingTime:
- addition of new record is understood as addition of new combination of values for the attributes creating unique identifier,
- modification of existing record is understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC rules to be established, e.g. cross-checking AuthorityInstanceId against Zone table or MeasurementStation table.

Valid modifications of existing record in this table are almost all allowed, only correction of AuthorityInstance may be restricted as it depends on AuthorityInstanceId.
Validity of the modifications of existing record will be tested using QC rules to be established.
Allowed modifications are not supposed to affect outcomes of compliance analysis and/or assessments.

Data products for public will present the records with active AuthorityStatus and the latest ReportingTime for distinct combination of CountryCode, AuthorityInstanceId, AuthorityRole and AuthorityName so that PersonName and Email can be omitted.

Data products for reporters will present the records with active AuthorityStatus and the latest ReportingTime for each unique combination of CountryCode, AuthorityInstanceId, AuthorityRole and Email, including PersonName.

## EEA extensions

Authority table will be extended by EEA by several attributes:
- Country (for convenience), based on ISO2 country codes,
- ReportingTime, registering time of the latest reporting or modification for each record.

## Data management rules

Records in Authority table which have AuthorityStatus as inactive for 3 consecutive years will be flagged for deletion in the reference data flow.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| AUT_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| AUT_02 | AuthorityInstanceId | varchar(50) | string | PK |  |  |
| AUT_03 | AuthorityRole | varchar(50) | string | PK | [authorityobject](https://dd.eionet.europa.eu/vocabulary/aq/authorityobject) |  |
| AUT_04 | Email | varchar(50) | string | PK |  |  |
| AUT_05 | AuthorityInstance | varchar(20) | string |  | [authorityinstance](https://dd.eionet.europa.eu/vocabulary/aq/authorityinstance) |  |
| AUT_06 | AuthorityName | varchar(150) | string |  |  |  |
| AUT_07 | AuthorityURL | varchar(150) | string |  |  |  |
| AUT_08 | AuthorityAddress | varchar(150) | string |  |  |  |
| AUT_09 | PersonName | varchar(150) | string |  |  |  |
| AUT_10 | AuthorityStatus | varchar(10) | string |  | [aq/authoritystatus/](https://dd.eionet.europa.eu/vocabulary/aq/authoritystatus/) |  |

## Attribute details

### AUT_01 – CountryCode


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-01-countrycode)
**Content**

Country or territory ISO2 code.

### AUT_02 – AuthorityInstanceId


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-02-authorityinstanceid)
**Content**

Unique identifier depending on authority instance, e.g. ZoneId or NUTS code.

**Remarks**

If AuthorityInstance is zone then AuthorityInstanceId is a ZoneId, if nuts then nuts code, if network - network id, etc.

It will be cross-checked against ARZ, STA, SPO or MOD table depending on the instance level.

### AUT_03 – AuthorityRole


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-03-authorityrole)
**Content**

A general object identifier or classification (topic e.g. reporting, assessment etc.).

### AUT_04 – Email


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-04-email)
**Content**

Email address of the contact person.

**Remarks**

Email have to be filled in but reporting details on person’s email are necessary only for reporters who need access to the ReportNet3.

An informed consent statement will be attached clarifying that this data will be used for establishing access rights and filling it in means both access request and consent for data use.

In other cases the attribute should be filled in as "Not Reported" or with organisation generic email address.

### AUT_05 – AuthorityInstance


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-05-authorityinstance)
**Content**

Name of the authority instance: zone, network, nuts0, nuts1, nuts2, nuts3, station, SPO, etc.

### AUT_06 – AuthorityName


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-06-authorityname)
**Content**

Name of the institute or organization.

### AUT_07 – AuthorityURL


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-07-authorityurl)
**Content**

Website URL of the institute.

### AUT_08 – AuthorityAddress


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-08-authorityaddress)
**Content**

Address of the institute.

### AUT_09 – PersonName


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-09-personname)
**Content**

Name of the contact person in the authority or institute.

**Remarks**

PersonName have to be filled in but reporting details on person’s name are necessary only for reporters who need access to the ReportNet3.

An informed consent statement will be attached clarifying that this data will be used for establishing access rights and filling it in means both access request and consent for data use.

In other cases the attribute should be filled in as "Not Reported".

### AUT_10 – AuthorityStatus


**Reference**

[View reference attribute](https://eeadata.github.io/AQ.Documentation.ReferenceGuidePilot/tables/Authority.html#aut-10-authoritystatus)
**Content**

Status or classification of the authority (e.g. active/inactive).

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
AUT_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
AUT_02 | AuthorityInstanceId | DU | varchar(50) | string | ✓ | 
AUT_03 | AuthorityRole | 1 | varchar(50) | string | ✓ | ✓
AUT_04 | Email | eve.bot@dema.dus | varchar(50) | string | ✓ | 
AUT_05 | AuthorityInstance | nuts0 | varchar(20) | string |  | ✓
AUT_06 | AuthorityName | Dustovia Environmental Agency (DEA) – Air Quality Division | varchar(150) | string |  | 
AUT_07 | AuthorityURL | www.dea.dustovia.dus | varchar(150) | string |  | 
AUT_08 | AuthorityAddress | 42 CleanAir St, Terminalgrad, Dustovia (DUS-4242) | varchar(150) | string |  | 
AUT_09 | PersonName | E.V.E. Bot | varchar(150) | string |  | 
AUT_10 | AuthorityStatus | active | varchar(10) | string |  | ✓

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `Authority`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)