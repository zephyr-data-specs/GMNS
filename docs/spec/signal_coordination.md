## `signal_coordination`
  - `description` Establishes coordination for several signal controllers, associated with a timing_plan.
  - `path` signal_coordination.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['coordination_id']
    - `foreignKeys`
      - [1]
        - `fields` ['timing_plan_id']
        - `reference`
          - `resource` signal_timing_plan
          - `fields` ['timing_plan_id']
      - [2]
        - `fields` ['controller_id']
        - `reference`
          - `resource` signal_controller
          - `fields` ['controller_id']
      - [3]
        - `fields` ['coord_contr_id']
        - `reference`
          - `resource` signal_controller
          - `fields` ['controller_id']
    - `fieldsMatch` subset
  
| name            | type    | description                                                                                                                        | constraints                   | categories                                            |
|:----------------|:--------|:-----------------------------------------------------------------------------------------------------------------------------------|:------------------------------|:------------------------------------------------------|
| coordination_id | any     | Primary key.                                                                                                                       | {'required': True}            |                                                       |
| timing_plan_id  | any     | Required. Foreign key (Signal_timing_plan table).                                                                                  | {'required': True}            |                                                       |
| controller_id   | any     | Required. Foreign key (signal_controller table).                                                                                   | {'required': True}            |                                                       |
| coord_contr_id  | any     | Optional. For coordinated signals, the master signal controller for coordination.                                                  |                               |                                                       |
| coord_phase     | integer | Optional. For coordinated signals, the phase at which coordination starts (time 0).                                                | {'minimum': 0, 'maximum': 32} |                                                       |
| coord_ref_to    | string  | Optional. For coordinated signals, the part of the phase where coordination starts: begin_of_green, begin_of_yellow, begin_of_red. |                               | ['begin_of_green', 'begin_of_yellow', 'begin_of_red'] |
| offset          | number  | Optional. Offset in seconds.                                                                                                       | {'minimum': 0}                |                                                       |