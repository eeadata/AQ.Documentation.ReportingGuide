# ObservationMeasurementResultPNSD

```{image} ../_static/table-icons/ObservationMeasurementResultPNSD.png
:alt: ObservationMeasurementResultPNSD
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
| OMP_01 | CountryCode | varchar(2) | string | PK | [countries](https://dd.eionet.europa.eu/vocabulary/common/countries) |  |
| OMP_02 | AssessmentMethodId | varchar(100) | string | PK |  |  |
| OMP_03 | Start | datetime | datetime | PK |  |  |
| OMP_04 | LowerRange | int | numeric | PK |  |  |
| OMP_05 | PollutantId | int | numeric |  | [pollutant](https://dd.eionet.europa.eu/vocabulary/aq/pollutant/view) |  |
| OMP_06 | End | datetime | datetime |  |  |  |
| OMP_07 | Value | decimal(10,2) | numeric |  |  |  |
| OMP_08 | Unit | varchar(10) | string |  | [concentration](https://dd.eionet.europa.eu/vocabulary/uom/concentration/) |  |
| OMP_09 | Validity | int | numeric |  | [observationvalidity](https://dd.eionet.europa.eu/vocabulary/aq/observationvalidity/view) |  |
| OMP_10 | Verification | int | numeric |  | [observationverification](https://dd.eionet.europa.eu/vocabulary/aq/observationverification/view) |  |
| OMP_11 | TimeResolution | varchar(10) | string |  | [primaryObservation](https://dd.eionet.europa.eu/vocabulary/aq/primaryObservation/view) |  |
| OMP_12 | ResultTime | datetime | datetime |  |  |  |
| OMP_13 | UpperRange | int | numeric |  |  |  |
| OMP_14 | Temperature | decimal(5,2) | numeric |  |  |  |
| OMP_15 | RelativeHumidity | decimal(5,2) | numeric |  |  |  |
| OMP_16 | Pressure | decimal(5,2) | numeric |  |  |  |
| OMP_17 | Inversion | varchar(20) | string |  | [PNSDinversion](https://dd.eionet.europa.eu/vocabulary/aq/PNSDinversion) |  |

```{note}
Attributes with ReportNet3 data type `date` or `datetime` shall use the ISO 8601 format. Date-time values may include a local UTC offset.
```

## Attribute details

### OMP_01 – CountryCode

**Content**

Country or territory ISO2 code.

### OMP_02 – AssessmentMethodId

**Content**

Identifier of the assessment method (sampling point), given by data provider.

**Remarks**

It will be cross-checked against the SamplingPoint table.

### OMP_03 – Start

**Content**

Start date and time of the measurement period.

**Remarks**

Start must be provided with time zone information.

### OMP_04 – LowerRange

**Content**

Lower range of PNSD bin.

### OMP_05 – PollutantId

**Content**

Code of the air pollutant being measured, as per Data Dictionary standards.

**Remarks**

End must be provided with time zone information.

### OMP_06 – End

**Content**

End date and time of the measurement period.

### OMP_07 – Value

**Content**

Measured concentration or level of the air pollutant.

### OMP_08 – Unit

**Content**

 Unit of measurement for the air pollution level (e.g., µg/m³).

### OMP_09 – Validity

**Content**

Indicator of whether the measurement data is valid or not.

### OMP_10 – Verification

**Content**

Information based on verification flags found in reported time series.

### OMP_11 – TimeResolution

**Content**

Time resolution of the reported measurement observations (e.g., hourly, daily).

### OMP_12 – ResultTime

**Content**

Time at which the result was generated or recorded.

### OMP_13 – UpperRange

**Content**

Upper range of PNSD bin.

### OMP_14 – Temperature

**Content**

Temperature measured along the PNSD (deg Celsius).

### OMP_15 – RelativeHumidity

**Content**

Relative humidity measured along the PNSD (%).

### OMP_16 – Pressure

**Content**

Pressure measured along the PNSD (hPa).

### OMP_17 – Inversion

**Content**

Inversion method used by country (code list flag).

## Example

No example is provided in the workbook for this table.

[Download complete examples workbook](../_static/R3_v501_AQ_Reporting_guide_example.xlsx)
