# MOEResultExternal

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

The purpose of the MOEResultExternal table is to collect information on results from air quality modelling applications. It is similar to the table MREResultInline except that here the results are submitted in attached GEOTIFF file, following the common grid approach (see Introduction). 

MOEResultExternal table has to be reported every year (if models/OBE are declared for compliance) because new information is expected at each reporting cycle.
Attributes which create unique identifier of each record: CountryCode, AssessmentMethodId, Start and DataAggregationProcessId.

Updates of the MOEResultExternal table will not be time stamped - i.e. each update generates the only version of the (gridded) AQ values that is stored at the EEA, as well - the only version of the corresponding table in reference/legacy data:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against existing records in ModelObjectiveEstimation table.

Valid modifications of existing record in this table are based on re-submission of a GEOTIFF file for the existing set of attributes creating unique identifier:
- either to overwrite/correct the values of other attributes,
- or to modify Validity flag to -1 for deletion purpose.
Validity of the modifications will be tested using QC (rules to be established).
Allowed modifications may affect outcomes of compliance analysis and/or assessments. Therefore, re-submissions for past years, for which compliance reporting has already been completed, will require additional tests against reference/legacy data before official release of such data is granted.

Data products for the public will present records validated at the latest deadline.
Data products for reporters will present records as most recently reported, highlighting differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

Reference data flow will have two tables representing reporting of model/OBE results:
- MOEResultInventory;
- MOEResultGrid.
MOEResultInventory will collect information about count of values reported for each model/OBE and year with certain settings (validity, verification, spatial resolution, etc.) and will contain a reference to raw data file. MOEResultGrid table will differ from the reporting data flow however it will contain gridded AQ values in 3 layers: 
- 2 Very High Resolution layers (10 and 100m - depending on original resolutions) for populated areas, traffic links and areas with values above thresholds, 
- 1 High Resolution layer (1000m) for all areas.

MOEResultGrid table will be extended by several attributes:
- Pollutant (for convenience), based on code list,
- DataAggregationProcess, based on DataAggregationProcessId,
- SourceDataFlow (R2 e-Reporting, R3 e-Reporting),
- Verification,
- Grid number identifiers, based on X,Y (SRID 3035).

## Data management rules

Results from modelling reported through external files should point to a record in the ModelObjectiveEstimation table with:

```text
ResultEncoding = 'external'
```

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| MRE_01 | CountryCode | varchar(2) | string | PK | [https://dd.eionet.europa.eu/vocabulary/common/countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| MRE_02 | AssessmentMethodId | varchar(100) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[ModelObjectiveEstimation](ModelObjectiveEstimation.md) |
| MRE_03 | Start | datetime | datetime | PK |  |  |
| MRE_04 | DataAggregationProcessId | varchar(50) | string | PK | [https://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/view](https://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/view) | [ModelObjectiveEstimation](ModelObjectiveEstimation.md) |
| MRE_05 | PollutantId | int | numeric |  | [https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| MRE_06 | End | datetime | datetime |  |  |  |
| MRE_07 | Unit | varchar(10) | string |  | [https://dd.eionet.europa.eu/vocabulary/uom/concentration/](https://dd.eionet.europa.eu/vocabulary/uom/concentration/) |  |
| MRE_08 | Validity | int | numeric |  | [https://dd.eionet.europa.eu/vocabulary/aq/observationvalidity/view](https://dd.eionet.europa.eu/vocabulary/aq/observationvalidity/view) |  |
| MRE_09 | SpatialResolution | int | numeric |  | [https://dd.eionet.europa.eu/vocabulary/aq/spatialresolution](https://dd.eionet.europa.eu/vocabulary/aq/spatialresolution) |  |
| MRE_10 | ResultTime | datetime | datetime |  |  |  |
| MRE_11 | GeoTiffAttachment | varchar(100) | attachment (R3 data type) |  |  |  |

```{note}
Attributes with ReportNet3 data type `date` or `datetime` shall use the ISO 8601 format. Date-time values may include a local UTC offset.
```

## Attribute details

### MRE_01 – CountryCode

**Content**

Country or territory ISO2 code.

### MRE_02 – AssessmentMethodId

**Content**

Identifier of the assessment method (model), given by provider.

**Remarks**

It will be cross-checked against the Model table.

### MRE_03 – Start

**Content**

Start date and time of the model simulation period.

**Remarks**

Start must be provided with time zone.
This information will be used for recalculation of all datetimes into UTC+1 for storage and analytical purposes.

### MRE_04 – DataAggregationProcessId

**Content**

Identifier for the process of aggregating model data into statistical values.

### MRE_05 – PollutantId

**Content**

Code of the air pollutant being modeled, as per Data Dictionary standards.

### MRE_06 – End

**Content**

End date and time of the model simulation period.

**Remarks**

End must be provided with time zone. 
This information will be used for recalculation of all datetimes into UTC+1 for storage and analytical purposes.

### MRE_07 – Unit

**Content**

Unit of measurement for the air pollution level (e.g., µg/m³).

**Remarks**

Units must follow those recommended unit for AQD pollutants.

### MRE_08 – Validity

**Content**

Indicator of whether the model data is valid or flagged.

### MRE_09 – SpatialResolution

**Content**

Description of the spatial resolution of the model output, indicating the level of detail - new code list.

**Remarks**

SpatialResolution will be tested against the code list for allowed values.

### MRE_10 – ResultTime

**Content**

Time at which the model results were generated or recorded.

### MRE_11 – GeoTiffAttachment

**Content**

Attached GEOTIFF.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
MRE_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
MRE_02 | AssessmentMethodId | MOD_DU_PM10_NAT_SR | varchar(100) | string | ✓ | 
MRE_03 | Start | 2021-01-01T00:00:00 | datetime | datetime | ✓ |
MRE_04 | DataAggregationProcessId | P1Y | varchar(50) | string | ✓ | ✓
MRE_05 | PollutantId | 5 | int | numeric |  | ✓
MRE_06 | End | 2022-01-01T00:00:00 | datetime | datetime |  |
MRE_07 | Unit | ug/m3 | varchar(10) | string |  | ✓
MRE_08 | Validity | 1 | int | numeric |  | ✓
MRE_09 | SpatialResolution | 1000 | int | numeric |  | ✓
MRE_10 | ResultTime | 2023-04-14T10:19:44 | datetime | datetime |  |
MRE_11 | GeoTiffAttachment |  | varchar(100) | attachment (R3 data type) |  | 

**Legend:** PK = Primary Key; FK = Foreign Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `MOEResultExternal`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
