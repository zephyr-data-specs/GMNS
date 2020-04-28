# Time of Day files

Four time-of-day files handle day-of-week and time-of-day restrictions and other attributes on links, segments, lanes, lane_segments and movements

# link_tod

link_tod is an optional file that handles day-of-week and time-of-day
restrictions on links. It is used for tolls (which may differ by
time-of-day), and part-time changes in link capacity. Since tolls often vary by time of day, they are placed in
this file.

link_tod data dictionary

| Field			| Type 			| Required? | Comment									|
| ------------- | ------------- | --------- | ----------------------------------------- |
| link_tod\_id  | Link_TOD\_ID  | Required  | Primary key                               |
| link\_id 		| Link\_ID 		| Required  | Foreign key, link table                    |
| time_day      | TimeDay\_Set 	| Optional  | Define the availability/role of lane at different dates and times    |
| capacity 		| INTEGER 		| Optional  | 											 |
| freespeed		| INTEGER		| Optional	|											|
| lanes			| INTEGER		| Optional	|											|
| bike\_facility	| TEXT			| Optional	|											|
| ped\_facility	| TEXT			| Optional	|											|
| parking	| TEXT			| Optional	|											|
| allowed\_uses | Use\_Set      | Required  |                                           |
| toll          | INTEGER       | Optional  | cents                                     |
| notes         | TEXT          | Optional  |                                           |

# segment_tod

segment_tod is an optional file that handles day-of-week and time-of-day restrictions on segments. 
It is used for part-time changes in segment capacity and number of lanes.

segment_tod data dictionary

| Field			| Type 			| Required? | Comment									|
| ------------- | ------------- | --------- | ----------------------------------------- |
| segment\_tod\_id  | Segment\_TOD\_ID  | Required  | Primary key                               |
| segment\_id 	| Segment\_ID 	| Required	| Foreign key, segment table.  |
| time_day      | TimeDay\_Set 	| Required | Define the availability/role of lane at different dates and times    |
| capacity 		| INTEGER 		| Optional  | 											 |
| freespeed		| INTEGER		| Optional	|											|
| lanes			| INTEGER		| Optional	|											|
| l\_lanes\_added	| INTEGER		| Optional	|											|
| r\_lanes\_added	| INTEGER		| Optional	|											|
| bike\_facility	| TEXT			| Optional	|											|
| ped\_facility	| TEXT			| Optional	|											|
| parking	| TEXT			| Optional	|											|
| allowed\_uses | Use\_Set      | Required  |                                           |
| toll          | INTEGER       | Optional  | cents                                     |
| notes         | TEXT          | Optional  |                                           |

# link_lane_tod

| Field			| Type 			| Required? | Comment									|
| ------------- | ------------- | --------- | ----------------------------------------- |
| link_tod\_id  | Link_TOD\_ID  | Required  | Primary key                               |
| link\_id 		| Link\_ID 		| Required  | Foreign key, link table                    |
| time\_day      | TimeDay\_Set 	| Required  | Define the availability/role of lane at different dates and times    |
| lane\_num      | INTEGER       | Required  |   |
| allowed\_uses  | Use\_Set     | Required  |   |
| r_barrier      | TEXT         | Optional  |    |
| l_barrier      | TEXT         | Optional   |    |
| width          | DOUBLE       | Optional   |    |
| notes          | TEXT         | Optional   |     |

# segment_lane_tod

| Field			| Type 			| Required? | Comment									|
| ------------- | ------------- | --------- | ----------------------------------------- |
| segment\_tod\_id  | Segment\_TOD\_ID  | Required  | Primary key                               |
| segment\_id 	| Segment\_ID 	| Required	| Foreign key, segment table.  |
| time_day      | TimeDay\_Set 	| Required | Define the availability/role of lane at different dates and times    |
| lane\_num      | INTEGER       | Required  |   |
| allowed\_uses  | Use\_Set     | Required  |   |
| r_barrier      | TEXT         | Optional  |    |
| l_barrier      | TEXT         | Optional   |    |
| width          | DOUBLE       | Optional   |    |
| notes          | TEXT         | Optional   |     |

## Relationships
![Relationships with the link_tod table](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/link_tod.png)
