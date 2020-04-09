# link_tod

link_tod is an optional file that handles day-of-week and time-of-day
restrictions on links and lanes. It is used for tolls (which may differ by
time-of-day), peak hour shoulder use, reversible lanes, and part time
parking lanes. Since tolls often vary by time of day, they are placed in
this file.

link_tod data dictionary

| Field                                         | Type           | Required? | Comment                                                                                                        |
| --------------------------------------------- | -------------- | --------- | -------------------------------------------------------------------------------------------------------------- |
| link_tod\_id  | Link_TOD\_ID  | Required  | Primary key                                                                                                    |
| road\_link\_id | Road\_Link\_ID | Required  | Foreign key, road\_link table                                                                                  |
| segment\_id | Segment\_ID | Optional  | Foreign key, segment table. If no value is entered, this table row applies to the entire road\_link |
| lane\_num   | INTEGER        | Optional  | If no value is entered, this table row applies to all of the lanes on the road\_link |
| time_day        | TimeDay\_Set   | Optional  | Define the availability/role of lane at different dates and times                                              |
| allowed\_uses                                 | Use\_Set       | Required  |                                                                                                                |
| toll                                          | INTEGER        | Optional  | cents                                                                                                          |
| notes                                         | TEXT           | Optional  |                                                                                                                |

## Relationships
![Relationships with the link_tod table](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/link_tod.png)