# MOEResultInline

```{image} ../_static/table-icons/MOEResultInline.png
:alt: MOEResultInline
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the MOEResultInline table is to collect information on (aggregated and gridded) results from air quality modelling applications. It describes the AQ values, time reference and the area of modelling in a set of grid cells following the common grid approach (see Introduction).

MOEResultInline table has to be reported every year (if models/OBE are declared for compliance) because new information is expected at each reporting cycle.
Attributes which create unique identifier of each record: CountryCode, AssessmentMethodId, Start, DataAggregationProcessId, X and Y.

Updates of the MOEResultInline table will not be time stamped - i.e. each update generates the only version of the (gridded) AQ values that is stored at the EEA, as well - the only version of the corresponding table in reference/legacy data:
- either as addition of new record, understood as addition of new combination of values for the attributes creating unique identifier,
- or modification of existing record, understood as modification of a value for any other attribute.
Validity of the new record will be tested using QC (rules to be established) - e.g. cross checking against existing records in ModelObjectiveEstimation table.

Valid modifications of existing record in this table are based on re-submission of the (gridded) AQ values for the existing set of attributes creating unique identifier:
- either to overwrite/correct the values of other attributes,
- or to modify Validity flag to -1 for deletion purpose.
Validity of the modifications of existing record will be tested using QC (rules to be established).
Allowed modifications may affect outcomes of compliance analysis and/or assessments, therefore re-submissions for past years, for which compliance reporting has been already done, will require additional tests vs reference/legacy data before official release of such data is granted.

Data products for public will present the records validated at the latest deadline.
Data products for reporters will present the records as reported recently, highlighting the differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

Reference data flow will have two tables representing reporting of model/OBE results:
- MOEResultInventory;
- MOEResultGrid.
MOEResultInventory will collect information about count of values reported for each model/OBE and year with certain settings (validity, verification, spatial resolution, etc.) and will contain a reference to raw data file.

MOEResultGrid table will differ from the reporting data flow however it will contain gridded AQ values in 3 layers:
- 2 Very High Resolution layers (10 and 100m - depending on original resolutions) for populated areas, traffic links and areas with values above thresholds,
- 1 High Resolution layer (1000m) for all areas.

MOEResultGrid table will be extended by several attributes:
- Pollutant (for convenience), based on code list,
- DataAggregationProcess, based on DataAggregationProcessId,
- SourceDataFlow (R2 e-Reporting, R3 e-Reporting),
- Verification,
- Grid number identifiers, based on X,Y (SRID 3035).

## Data management rules

Results from modelling reported inline should point to record in ModelObjectiveEstimation table with ResultEncoding = ' inline'.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| MRI_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| MRI_02 | AssessmentMethodId | varchar(100) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[ModelObjectiveEstimation](ModelObjectiveEstimation.md) |
| MRI_03 | Start | datetime | datetime | PK |  |  |
| MRI_04 | DataAggregationProcessId | varchar(50) | string | PK | [aggregationprocess](https://dd.eionet.europa.eu/vocabulary/aq/aggregationprocess/view) | [ModelObjectiveEstimation](ModelObjectiveEstimation.md) |
| MRI_05 | X | bigint | numeric | PK |  |  |
| MRI_06 | Y | bigint | numeric | PK |  |  |
| MRI_07 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| MRI_08 | End | datetime | datetime |  |  |  |
| MRI_09 | Value | decimal(10,2) | numeric |  |  |  |
| MRI_10 | Unit | varchar(10) | string |  | [concentration](https://dd.eionet.europa.eu/vocabulary/uom/concentration/) |  |
| MRI_11 | Validity | int | numeric |  | [observationvalidity](https://dd.eionet.europa.eu/vocabulary/aq/observationvalidity/view) |  |
| MRI_12 | SpatialResolution | int | numeric |  | [spatialresolution](https://dd.eionet.europa.eu/vocabulary/aq/spatialresolution) |  |
| MRI_13 | ResultTime | datetime | datetime |  |  |  |

```{note}
Attributes with ReportNet3 data type `date` or `datetime` shall use the ISO 8601 format. Date-time values may include a local UTC offset.
```

## Attribute details

### MRI_01 – CountryCode

**Content**

Country or territory ISO2 code.

### MRI_02 – AssessmentMethodId

**Content**

Identifier of the assessment method (model), given by provider.

**Remarks**

It will be cross-checked against the Model table.

### MRI_03 – Start

**Content**

Start date and time of the model simulation period.

**Remarks**

Start must be provided with time zone.
This information will be used for recalculation of all datetimes into UTC+1 for storage and analytical purposes.

### MRI_04 – DataAggregationProcessId

**Content**

Identifier for the process of aggregating model data into statistical values.

### MRI_05 – X

**Content**

X-coordinate of the modeled data point in a projected coordinate reference system.

**Remarks**

It must be using SRID 3035.

### MRI_06 – Y

**Content**

Y-coordinate of the modeled data point in a projected coordinate reference system.

**Remarks**

It must be using SRID 3035.

### MRI_07 – PollutantId

**Content**

Code of the air pollutant being modeled, as per Data Dictionary standards.

### MRI_08 – End

**Content**

End date and time of the model simulation period.

**Remarks**

End must be provided with time zone.
This information will be used for recalculation of all datetimes into UTC+1 for storage and analytical purposes.

### MRI_09 – Value

**Content**

Modeled concentration or level of the air pollutant.

### MRI_10 – Unit

**Content**

Unit of measurement for the air pollution level (e.g., µg/m³).

**Remarks**

Units must follow those recommended unit for AQD pollutants.

### MRI_11 – Validity

**Content**

Indicator of whether the model data is valid or flagged.

### MRI_12 – SpatialResolution

**Content**

Description of the spatial resolution of the model output, indicating the level of detail.

**Remarks**

SpatialResolution will be tested against code list for allowed values.

### MRI_13 – ResultTime

**Content**

Time at which the model results were generated or recorded.

## Example

| Attribute Code | Attribute Name | Example | SQL DB Data Type | ReportNet3 Data Type | PK | CL |
| --- | --- | --- | --- | --- | --- | --- |
MRI_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
MRI_02 | AssessmentMethodId | OBE_DU_SEASALT_PM10_H_LV_ADJ | varchar(100) | string | ✓ | 
MRI_03 | Start | 2024-01-01T00:00:00 | datetime | datetime | ✓ |
MRI_04 | DataAggregationProcessId | P1D | varchar(50) | string | ✓ | ✓
MRI_05 | X | 3463000 | bigint | numeric | ✓ | 
MRI_06 | Y | 2245000 | bigint | numeric | ✓ | 
MRI_07 | PollutantId | 5 | int | numeric |  | ✓
MRI_08 | End | 2024-01-02T00:00:00 | datetime | datetime |  |
MRI_09 | Value | 1 | decimal(10,2) | numeric |  | 
MRI_10 | Unit | ug/m3 | varchar(10) | string |  | ✓
MRI_11 | Validity | 1 | int | numeric |  | ✓
MRI_12 | SpatialResolution | 1000 | int | numeric |  | ✓
MRI_13 | ResultTime | 2025-09-14T10:19:44 | datetime | datetime |  |

**Legend:** PK = Primary Key; FK = Foreign Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `MOEResultInline`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
