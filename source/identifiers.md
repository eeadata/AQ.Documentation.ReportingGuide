# Identifiers

```{contents}
:local:
:depth: 2
```

## Description

This section describes the identifier formats used throughout the reporting schema.

Some identifiers follow a fully mandatory naming convention in order to ensure consistency across reporting authorities and facilitate automatic processing by the EEA. Other identifiers are partially constrained or completely free.

Unless specified otherwise, identifier values must be unique within the scope of the reporting country.

## Identifier categories

### Fully mandatory identifier formats

The following identifiers must follow the format specified in this guide:

* AssessmentRegimeId
* SamplingPointReferenceId
* AttainmentId
* SpatialRepresentativenessId
* ScenarioId

### Partially mandatory identifier formats

The following identifiers have mandatory prefixes or structural elements, while other parts may be defined by the reporting authority:

* AssessmentMethodId (models and OBE)
* PlanId

### Free-format identifiers

All remaining identifiers may be freely defined by reporting authorities.

For readability and easier interpretation, it is strongly recommended to use meaningful prefixes indicating the identifier type, for example:

| Prefix | Meaning                    |
| ------ | -------------------------- |
| NET    | Network                    |
| DOC    | Document                   |
| SAP    | Source Apportionment       |
| EXC    | Exceedance Extent          |
| PLA    | Plan                       |
| MOD    | Model                      |
| OBE    | Objective Estimation       |

## Separators

For fully mandatory identifiers, the separator must be:

```text
_
```

For all other identifiers, including partially mandatory identifiers, any separator may be used, for example:

```text
_
-
.
```

## AssessmentRegimeId

**Referenced in:** ARZ_02

Mandatory format:

```text
ARE_<ZoneId>_<PollutantId>_<ObjectiveType>_<ProtectionTarget>_<ReportingMetric>_<ClassificationYear>_<Index>
```

Example:

```text
ARE_ZON_DU000A_0005_LV_H_aMean_2021_1
```

| Element            | Description                               |
| ------------------ | ----------------------------------------- |
| ARE                | Fixed prefix indicating Assessment Regime |
| ZoneId             | Air quality zone identifier               |
| PollutantId        | Pollutant code                            |
| ObjectiveType      | Environmental objective type              |
| ProtectionTarget   | Protection target                         |
| ReportingMetric    | Reporting metric                          |
| ClassificationYear | Year of classification                    |
| Index              | Sequential number                         |

## SamplingPointReferenceId

**Referenced in:** SPO_03

Mandatory format:

```text
SPOref_<StationEoICode>_<PollutantId>_<Index>
```

Example:

```text
SPOref_DU0001_0005_1
```

| Element        | Description                                      |
| -------------- | ------------------------------------------------ |
| SPOref         | Fixed prefix indicating Sampling Point Reference |
| StationEoICode | Station identifier                               |
| PollutantId    | Pollutant code                                   |
| Index          | Sequential number                                |

## AttainmentId

**Referenced in:** CAM_15

Mandatory format:

```text
ATT_<ZoneId>_<PollutantId>_<ObjectiveType>_<ProtectionTarget>_<ReportingMetric>_<ReportingYear>_<Index>
```

Example:

```text
ATT_ZON_DU000A_0005_LV_H_aMean_2024_1
```

| Element          | Description                                  |
| ---------------- | -------------------------------------------- |
| ATT              | Fixed prefix indicating compliance situation |
| ZoneId           | Air quality zone identifier                  |
| PollutantId      | Pollutant code                               |
| ObjectiveType    | Environmental objective type                 |
| ProtectionTarget | Protection target                            |
| ReportingMetric  | Reporting metric                             |
| ReportingYear    | Reporting year                               |
| Index            | Sequential number                            |

## SpatialRepresentativenessId

**Referenced in:** CAM_15

- SRSId must be provided for each sampling point OR exceedance in the Compliance Assessment Method table

Mandatory format:

```text
SRS_<SamplingPointId>_<ReportingMetric>_<ReportingYear>
```

Example:

```text
SRS_DU0002_0005_100_daysAbove_2024
```

| Element          | Description                                        |
| ---------------- | -------------------------------------------------- |
| SRS              | Fixed prefix indicating spatial representativeness |
| SamplingPointId  | Sampling point identifier                          |
| ReportingMetric  | Reporting metric                                   |
| ReportingYear    | Reporting year                                     |

- SRSId must be provided for model indicating exceedance in the Compliance Assessment Method table

Mandatory format:

```text
SRS_<ZoneId>_<PollutantId>_<ReportingMetric>_<ReportingYear>_<Index>
```

Example:

```text
SRS_DU000B_00005_daysAbove_2024_1
```

| Element          | Description                                        |
| ---------------- | -------------------------------------------------- |
| SRS              | Fixed prefix indicating spatial representativeness |
| ZoneId           | Air quality zone identifier                        |
| PollutantId      | Pollutant code                                     |
| ReportingMetric  | Reporting metric                                   |
| ReportingYear    | Reporting year                                     |
| Index            | Sequential number                                  |

## ScenarioId

**Referenced in:** PSC_03, CPL_04

Mandatory format:

```text
SCE_<ZoneId>_<PollutantId>_<ObjectiveType>_<ProtectionTarget>_<ReportingMetric>_<Index>
```

Example:

```text
SCE_ZON_DU000B_0005_LV_H_daysAbove_1
```

| Element          | Description                      |
| ---------------- | -------------------------------- |
| SCE              | Fixed prefix indicating scenario |
| ZoneId           | Air quality zone identifier      |
| PollutantId      | Pollutant code                   |
| ObjectiveType    | Environmental objective type     |
| ProtectionTarget | Protection target                |
| ReportingMetric  | Reporting metric                 |
| Index            | Sequential number                |

## AssessmentMethodId for models and OBE

**Referenced in:** MOE_02

Partially mandatory format.

Recommended prefixes:

```text
MOD_
OBE_
```

Examples:

```text
MOD_DU_PM10_LOC_SCEN_REF
OBE_DU_SEASALT_PM10_H_LV_ADJ
```

| Prefix | Meaning               |
| ------ | --------------------- |
| MOD    | Modelling application |
| OBE    | Objective estimation  |

## PlanId

**Referenced in:** CPL_03

Partially mandatory format.

Recommended prefix:

```text
PLA_
```

Example:

```text
PLA_ZON_DU000B_0005_LV_H_daysAbove
```

| Element            | Description                    |
| ------------------ | ------------------------------ |
| PLA                | Fixed prefix indicating plan   |
| Remaining elements | Defined by reporting authority |

```
```
