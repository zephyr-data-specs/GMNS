## `signal_timing_plan`
  - `description` For signalized nodes, establishes timing plans.
  - `path` signal_timing_plan.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['timing_plan_id']
    - `foreignKeys`
      - [1]
        - `fields` ['controller_id']
        - `reference`
          - `resource` signal_controller
          - `fields` ['controller_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
    - `fieldsMatch` subset
  
| name           | type   | description                                                                                                                                                                                 | constraints                    |
|:---------------|:-------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------|
| timing_plan_id | any    | Primary key.                                                                                                                                                                                | {'required': True}             |
| controller_id  | any    | Required. Foreign key (signal_controller table).                                                                                                                                            | {'required': True}             |
| timeday_id     | any    | Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.                                                                                                |                                |
| time_day       | any    | Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times. |                                |
| cycle_length   | number | Cycle length in seconds.                                                                                                                                                                    | {'minimum': 0, 'maximum': 600} |