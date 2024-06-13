## `schema`

| name                 | type   | description                                                                                                             | constraints                                  |
|:---------------------|:-------|:------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------|
| signal_phase_mvmt_id | any    | Primary key.                                                                                                            | {'required': True}                           |
| timing_phase_id      | any    | Associated entry in the timing phase table.                                                                             | {'required': True}                           |
| mvmt_id              | any    | Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required. |                                              |
| link_id              | any    | Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required. |                                              |
| protection           | string | Optional. Indicates whether the phase is protected, permitted, or right turn on red.                                    | {'enum': ['protected', 'permitted', 'rtor']} |