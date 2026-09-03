# ObservationMeasurementResult

```{image} ../_static/table-icons/ObservationMeasurementResult.png
:alt: ObservationMeasurementResult
:align: right
:width: 200px
```

```{contents}
:local:
:depth: 2
```

## Description

The purpose of the ObservationMeasurementResult table is to collect information on air quality measurement results. It describes the AQ values and time reference for each value. Location of each measurement can be identified through the SamplingPoint table.

ObservationMeasurementResult table has to be reported every year because new information is expected at each reporting cycle.
Attributes which create unique identifier of each record: CountryCode, AssessmentMethodId and Start.

Updates of the ObservationMeasurementResult table will not be time stamped - i.e. each update generates the only version of the time series with AQ values that is stored at the EEA, as well as the only version of the AQ statistics stored in the reference/legacy data:
- either as addition of a new record, understood as addition of a new combination of values for the attributes creating the unique identifier;
- or modification of an existing record, understood as modification of a value for any other attribute.
Validity of new records will be tested using QC procedures (rules to be established), including cross-checking against existing records in the SamplingPoint table.

Valid modifications of existing records are based on re-submission of time series for the existing set of attributes creating the unique identifier:
- either to overwrite or correct values of other attributes;
- or to modify the Validity flag to `-1` for deletion purposes.
Validity of modifications will be tested through QC procedures.
Allowed modifications may affect outcomes of compliance analysis and/or assessments. Therefore, re-submissions for past years, for which compliance reporting has already been completed, will require additional tests against reference/legacy data before official release of such data is granted.

Data products for the public (download services for time series and aggregated values) will present records validated at the latest deadline.
Data products for reporters will present records as most recently reported, highlighting differences between validated reports and recent reports in case of re-submissions.

## EEA extensions

Reference data flow will contain two tables representing reporting of time series:
- ObservationMeasurementInventory;
- ObservationMeasurementStatistics.

ObservationMeasurementInventory will collect information about counts of values reported for each sampling point and year with specific settings (validity, verification, time resolution, etc.) and will contain a reference to the raw data file.
ObservationMeasurementStatistics in the reference/legacy data flow will differ significantly from the reporting table because it will only contain aggregated values.

The scope of aggregations stored in that table remains to be agreed (P1D ?, P1M ?, annual only ?, etc.).
SamplingPointReferenceId will be used in the reference/legacy data flow together with AssessmentMethodId in order to preserve continuity.

ObservationMeasurementStatistics will also be extended by attributes such as:
- Pollutant (for convenience), based on code list;
- DataCoverage, as a feature of aggregated data;
- DataAggregationProcessId (P1Y, etc.);
- DataAggregationProcess, based on DataAggregationProcessId;
- SourceDataFlow (AirBase, R2 e-Reporting, R3 e-Reporting, UTD).

## Data management rules
Deletion of records from ObservationMeasurementResult can be achieved by re-submitting the same records with the Validity flag set to `-1`.

## Attributes

| Attribute Code | Attribute Name | SQL DB Data Type | ReportNet3 Data Type | Properties | Code list | Related table(s) |
|---|---|---|---|---|---|---|
| OMR_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| OMR_02 | AssessmentMethodId | varchar(100) | string | PK |  | [ComplianceAssessmentMethod](ComplianceAssessmentMethod.md)<br>[SamplingPoint](SamplingPoint.md)<br>[SamplingPointLocation](SamplingPointLocation.md)<br>[SamplingProcess](SamplingProcess.md) |
| OMR_03 | Start | datetime | datetime | PK |  |  |
| OMR_04 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| OMR_05 | End | datetime | datetime |  |  |  |
| OMR_06 | Value | decimal(10,2) | numeric |  |  |  |
| OMR_07 | Unit | varchar(10) | string |  | [concentration](https://dd.eionet.europa.eu/vocabulary/uom/concentration/) |  |
| OMR_08 | Validity | int | numeric |  | [observationvalidity](https://dd.eionet.europa.eu/vocabulary/aq/observationvalidity/view) |  |
| OMR_09 | Verification | int | numeric |  | [observationverification](https://dd.eionet.europa.eu/vocabulary/aq/observationverification/view) |  |
| OMR_10 | DataCapture | decimal(5,2) | numeric |  |  |  |
| OMR_11 | TimeResolution | varchar(10) | string |  | [primaryObservation](https://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/view) |  |
| OMR_12 | ResultTime | datetime | datetime |  |  |  |

```{note}
Attributes with ReportNet3 data type `date` or `datetime` shall use the ISO 8601 format. Date-time values may include a local UTC offset.
```

## Attribute details

### OMR_01 – CountryCode

**Content**

Country or territory ISO2 code.

### OMR_02 – AssessmentMethodId

**Content**

Identifier of the assessment method (sampling point), given by data provider.

**Remarks**

It will be cross-checked against the SamplingPoint table.

### OMR_03 – Start

**Content**

Start date and time of the measurement period.

**Remarks**

Start must be provided with time zone information.
This information will be used for recalculation of all datetimes into UTC+1 for storage and analytical purposes.

### OMR_04 – PollutantId

**Content**

Code of the air pollutant being measured, as per Data Dictionary standards.

### OMR_05 – End

**Content**

End date and time of the measurement period.

**Remarks**

End must be provided with time zone information.
This information will be used for recalculation of all datetimes into UTC+1 for storage and analytical purposes.

### OMR_06 – Value

**Content**

Measured concentration or level of the air pollutant.

### OMR_07 – Unit

**Content**

Unit of measurement for the air pollution level (e.g. µg/m³).

**Remarks**

Units must follow those recommended for AQD pollutants.

### OMR_08 – Validity

**Content**

Indicator of whether the measurement data is valid or not.

### OMR_09 – Verification

**Content**

Information based on verification flags found in reported time series.

### OMR_10 – DataCapture

**Content**

The proportion of valid measurement time relative to total measured time, expressed as a percentage.

### OMR_11 – TimeResolution

**Content**

Time resolution of the reported measurement observations (e.g. hourly, daily).

**Remarks**

TimeResolution must be consistent with End minus Start and will be tested through QC procedures.

### OMR_12 – ResultTime

**Content**

Time at which the result was generated or recorded.

## Example

OMR_01 | CountryCode | DU | varchar(2) | string | ✓ | ✓
OMR_02 | AssessmentMethodId | SPO_DU0001_0005_100 | varchar(100) | string | ✓ | 
OMR_03 | Start | 2024-01-01T00:00:00 | datetime | datetime | ✓ |
OMR_04 | PollutantId | 5 | int | numeric |  | ✓
OMR_05 | End | 2024-01-01T01:00:00 | datetime | datetime |  |
OMR_06 | Value | 16.4 | decimal(10,2) | numeric |  | 
OMR_07 | Unit | ug/m3 | varchar(10) | string |  | ✓
OMR_08 | Validity | 1 | int | numeric |  | ✓
OMR_09 | Verification | 1 | int | numeric |  | ✓
OMR_10 | DataCapture |  | decimal(5,2) | numeric |  | 
OMR_11 | TimeResolution | hour | varchar(10) | string |  | ✓
OMR_12 | ResultTime | 2025-09-28T16:12:36 | datetime | datetime |  |

**Legend:** PK = Primary Key; CL = Code List.

The complete set of examples is available in the Excel workbook, worksheet `ObservationMeasurementResult`.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
