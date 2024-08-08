## `signal_phase_mvmt`
  - `description` Associates Movements and pedestrian Links (e.g., crosswalks) with signal phases. A signal phase may be associated with several movements. A Movement may also run on more than one phase.
  - `path` signal_phase_mvmt.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['signal_phase_mvmt_id']
    - `foreignKeys`
      - [1]
        - `fields` ['timing_phase_id']
        - `reference`
          - `resource` signal_timing_phase
          - `fields` ['timing_phase_id']
      - [2]
        - `fields` ['mvmt_id']
        - `reference`
          - `resource` movement
          - `fields` ['mvmt_id']
      - [3]
        - `fields` ['link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
    - `fieldsMatch` subset
  
| name                 | type   | description                                                                                                             | constraints        | categories                         |
|:---------------------|:-------|:------------------------------------------------------------------------------------------------------------------------|:-------------------|:-----------------------------------|
| signal_phase_mvmt_id | any    | Primary key.                                                                                                            | {'required': True} |                                    |
| timing_phase_id      | any    | Associated entry in the timing phase table.                                                                             | {'required': True} |                                    |
| mvmt_id              | any    | Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required. |                    |                                    |
| link_id              | any    | Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required. |                    |                                    |
| protection           | string | Optional. Indicates whether the phase is protected, permitted, or right turn on red.                                    |                    | ['protected', 'permitted', 'rtor'] |