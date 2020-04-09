# movement

The movement file describes how inbound and outbound road\_links
connect at an intersection. The simplified structure for offroad\_links
implies that travel can occur from a given offroad link to any offroad
link sharing a node (including U-turn movements); no movements table is necessary.

Table 14 movement data dictionary

| Field                                           | Type             | Required? | Comment                                                      |
| ----------------------------------------------- | ---------------- | --------- | ------------------------------------------------------------ |
| <span class="underline">mvmt\_id</span> | Movement\_ID | Required  | Primary key                                                  |
| <span class="underline">node\_id</span>         | Node\_ID         | Required  | Foreign key (from Nodes table)                               |
| name                                            | TEXT             | Optional  |                                                              |
| <span class="underline">ib_link_id</span>         | Link\_ID         | Required  | Foreign key (from Road\_link table)                          |
| <span class="underline">ib_lane</span>         | INTEGER          | Optional  | Uses lane number                                             |
| <span class="underline">ob_link_id</span>         | Link\_ID         | Required  | Foreign key (from Road\_link table)                          |
| <span class="underline">ob_lane</span>         | INTEGER          | Optional  | Uses lane numbers or ranges of numbers                       |
| type                                            | TEXT             | Required  | LEFT, RIGHT, UTURN, THRU, MERGE, etc.                        |
| penalty                                         | INTEGER          | Optional  | Turn penalty (seconds)                                       |
| capacity                                        | INTEGER          | Optional  |                                                              |
| ctrl_type                                         | ControlType\_Set | Required  | From ControlType\_Set: No Control, Stop, Yield, Signal, etc. |
| notes                                           | TEXT             | Optional  |                                                              |

A question is whether traffic controls should be included in the
Movement file. Controls might include a type of control (e.g., YIELD,
STOP, SIGNAL), and an indication of which Movements yield to other
Movements.

# movement_tod

movement_tod is an optional file that handles day-of-week and
time-of-day restrictions on movements.

movement_tod data dictionary

| Field                                                | Type                  | Required? | Comment                                                                  |
| ---------------------------------------------------- | --------------------- | --------- | ------------------------------------------------------------------------ |
| mvmt_tod\_id | Movement_TOD\_ID | Required  | Primary key                                                              |
| mvmt\_id        | Movement\_ID        | Required  | Foreign key, the Movement to be restricted                             |
| time_day               | TimeDay\_Set          | Optional  | Define the availability/role of lane at different dates and times        |
| allowed\_uses                                        | Use\_Set              | Required  | A turn prohibition for all vehicles would have NONE as the allowed uses. |
| notes                                                | TEXT                  | Optional  |                                                                          |

## Relationships
![Relationships with the Movement and Movement_TOD tables](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/movement.png)
