## `schema`

| name             | type    | description                                                                                                        | constraints                                     |
|:-----------------|:--------|:-------------------------------------------------------------------------------------------------------------------|:------------------------------------------------|
| timing_phase_id  | any     | Primary key.                                                                                                       | {'required': True}                              |
| timing_plan_id   | any     | Foreign key; connects to a timing_plan associated with a controller.                                               |                                                 |
| signal_phase_num | integer | Signal phase number. Typically the NEMA phase number.                                                              | {'minimum': 0, 'required': True}                |
| min_green        | number  | The minimum green time in seconds for an actuated signal. Green time in seconds for a fixed time signal.           | {'minimum': 0}                                  |
| max_green        | number  | Optional.The maximum green time in seconds for an actuated signal; the default is minimum green plus one extension | {'minimum': 0}                                  |
| extension        | number  | Optional. The number of seconds the green time is extended each time vehicles are detected.                        | {'minimum': 0, 'maximum': 120}                  |
| clearance        | number  | Yellow interval plus all red interval                                                                              | {'minimum': 0, 'maximum': 120}                  |
| walk_time        | number  | If a pedestrian phase exists, the walk time in seconds                                                             | {'minimum': 0, 'maximum': 120}                  |
| ped_clearance    | number  | If a pedestrian phase exists, the flashing don't walk time.                                                        | {'minimum': 0, 'maximum': 120}                  |
| ring             | integer | Required. Set of phases that conflict with each other.                                                             | {'required': True, 'minimum': 0, 'maximum': 12} |
| barrier          | integer | Required. Set of phases that can operate other.                                                                    | {'required': True, 'minimum': 0, 'maximum': 12} |
| position         | integer | Required. Position.                                                                                                | {'required': True}                              |