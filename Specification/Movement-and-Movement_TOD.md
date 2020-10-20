# movement

The movement file describes how inbound and outbound road\_links
connect at an intersection. The simplified structure for offroad\_links
implies that travel can occur from a given offroad link to any offroad
link sharing a node (including U-turn movements); no movements table is necessary.

movement data dictionary

| Field                                           | Type             | Required? | Comment                                                      |
| ----------------------------------------------- | ---------------- | --------- | ------------------------------------------------------------ |
| <span class="underline">mvmt\_id</span> | Movement\_ID | Required  | Primary key                                                  |
| <span class="underline">node\_id</span>         | Node\_ID         | Required  | Foreign key (from Nodes table)                               |
| name                                            | TEXT             | Optional  |                                                              |
| <span class="underline">ib_link_id</span>         | Link\_ID         | Required  | Foreign key (from Link table)                          |
| <span class="underline">start_ib_lane</span>         | INTEGER          | Optional  | Innermost lane number the movement applies to at the inbound end                                            |
| end_ib_lane	|INTEGER	| Optional	| Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.	|
| <span class="underline">ob_link_id</span>         | Link\_ID         | Required  | Foreign key (from Link table)                          |
| <span class="underline">start_ob_lane</span>         | INTEGER          | Optional  | Innermost lane number the movement applies to at the outbound end                       |
| end_ob_lane	| INTEGER   	|	Optional  | Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.	|
| type                                            | TEXT             | Required  | left, right, uturn, thru, merge, etc.                        |
| penalty                                         | INTEGER          | Optional  | Turn penalty (seconds)                                       |
| capacity                                        | INTEGER          | Optional  |                                                              |
| ctrl_type                                         | ControlType\_Set | Required  | From ControlType\_Set: no_control, yield, stop, stop_2_way, stop_4_way, signal_with_RTOR, signal. stop_2_way means that the movement has stop sign control, with at least one other conflicting movment uncontrolled.  stop_4_way means that all other conflicting movements also have stop sign control |
| notes                                           | TEXT             | Optional  |                                                              |

A question is whether traffic controls should be included in the
Movement file. Controls might include a type of control (e.g., yield,
stop, signal), and an indication of which Movements yield to other
Movements.

# movement_tod

movement_tod is an optional file that handles day-of-week and
time-of-day restrictions on movements.

movement_tod data dictionary

| Field                                                | Type                  | Required? | Comment                                                                  |
| ---------------------------------------------------- | --------------------- | --------- | ------------------------------------------------------------------------ |
| mvmt_tod\_id | Movement_TOD\_ID | Required  | Primary key                                                              |
| mvmt\_id        | Movement\_ID        | Required  | Foreign key, the Movement to be restricted                             |
| time_day               | TimeDay\_Set          | Conditionally required | Define the availability/role of movement at different dates and times (either time_day or timeday_id is required)       |
| timeday_id      | TimeDay\_ID 	| Conditionally required  | Used if times-of-day are defined on the time_set_definitions table   |
| start_ib_lane	| INTEGER          | Optional  | Innermost lane number the movement applies to at the inbound end |
| end_ib_lane	| INTEGER          | Optional  | Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.	|
| start_ob_lane	| INTEGER          | Optional  | Innermost lane number the movement applies to at the outbound end	|
| end_ob_lane	| INTEGER          | Optional  | Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.	|
| type                                            | TEXT             | Required  | left, right, uturn, thru, merge, etc.                        |
| penalty                                         | INTEGER          | Optional  | Turn penalty (seconds)                                       |
| capacity                                        | INTEGER          | Optional  |                                                              |
| ctrl_type                                         | ControlType\_Set | Required  | From ControlType\_Set: no_control, yield, stop, stop_2_way, stop_4_way, signal_with_RTOR, signal |
| notes                                           | TEXT             | Optional  |                                                              |
                                                             |
