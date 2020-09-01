# Connecticut Avenue in Washington, DC 

This example is a stretch of Connecticut Avenue in NW Washington, DC. It demonstrates lane Time of Day (TOD) attributes. 

Street view of Connecticut Ave with Lanes labelled with Lane_IDs:

![Street view of CT Ave](https://github.com/zephyr-data-specs/GMNS/blob/master/Images/CT_Ave_1.png)

The attributes of each link change depending on the time of day. During the AM Peak, the southbound (SB) link is the more heavily traveled link, and vice versa for the PM Peak.

During non-peak hours: 

  - Each link has two travel lanes. 

  - Each link has a third lane of on-street parallel parking.  

During AM peak hours (07:00-09:30):

  - The SB link has four travel lanes while the NB link has two.

  - Both parking lanes become travel lanes.

  - Lane 1 of the NB link reverses direction to accommodate SB traffic.

During PM peak hours (16:00-18:30):

  - The NB link has four travel lanes while the SB link has two.

  - Both parking lanes become travel lanes.

  - Lane 1 of the SB link reverses direction to accommodate NB traffic.

How this portion of the street is represented by links and nodes is shown below:

![Links and nodes of CT Ave](https://github.com/zephyr-data-specs/GMNS/blob/master/Images/CT_Ave_2.png)


# Specifications

## Nodes

The nodes in this example represent the upstream and downstream intersections.

Table 1: node
| node_id | name | x_coord | y_coord | z_coord | node_type    | ctrl_type | zone_id | parent_node_id |
| ---	  | ---  | ---     | ---     | ---     | ---          | ---       | ---     | --- |
| 1	  | --   | 321828  | 4311071 | --      | intersection | signal    | --      | -- |
| 2	  | --   | 321944  | 4310808 | --      | intersection | signal    | --      | -- |


## Links

Two links represent the southbound (Link 5) and northbound (Link 6) travel. For the link table, we use the properties that the link has for the majority of the day and represent the peak hours in the link_tod table.

Table 2: link
| link_id | from_node_id | to_node_id | directed | parent_link_id | lanes | allowed_uses |
| ---	  | ---	         | ---        | ---      | ---            | ---   | ---          |
| 5	  | 1	         | 2          | true     | --             | 2     | bike, auto, truck, bus |
| 6       | 2	         | 1          | true     | 5              | 2     | bike, auto, truck, bus |

*Optional fields left blank for this example are: name, geometry_id, geometry, dir_flag, length, grade, facility_type, capacity, free_speed, bike_facility, ped_facility, parking, jurisdiction, & row_width

## Lanes

The two travel lanes and the lane of parking for each link are noted in this table. Like the link table, the properties of the lanes are the properties that are true for the majority of the day. The parking lane nor the entries for when a lane is reversed count towards the lanes field in the link table as they are not facilitating travel. Lanes with uses such as SHOULDER, PARKING, or NONE are necessary to include in the lane table if they have TOD changes that cause them to be used as travel lanes.

Table 3: lane
| lane_id | link_id | lane_num | allowed_uses | r_barrier | l_barrier | width |
| ---     | ---     | ---      | ---          | ---       | ---       | ---   |
| 50      | 5       | -1       | none         | --        | --        | 10    |
| 51      | 5       | 1        | all          | --        | --        | 10    |
| 52      | 5       | 2        | all          | --        | --        | 10    |
| 53      | 5       | 3        | parking      | --        | --        | 10    | 
| 60      | 6       | -1       | none         | --        | --        | 10    |
| 61      | 6       | 1        | all          | --        | --        | 10    |
| 62      | 6       | 2        | all          | --        | --        | 10    |
| 63      | 6       | 3        | parking      | --        | --        | 10    |

## Link TOD

The link_tod table captures the change in the number of travel lanes for different times of day. In this example, during the peak hours of use the links gain two lanes for a total of four travel lanes.

Table 4: link_tod
| link_tod_id | link_id | time_day           | timeday_id | lanes | allowed_uses |
| ---         | ---	| ---                | ---        | ---	  | ---          |
| 7           | 5	| 01111100_0700_0930 | ---        | 4	  | bike, auto, truck, bus  |
| 8           | 6	| 01111100_1600_1830 | ---        | 4	  | bike, auto, truck, bus  |
| 9           | 6	| 01111100_0700_0930 | ---        | 2	  | bike, auto, truck, bus  |
| 10          | 5	| 01111100_1600_1830 | ---        | 2	  | bike, auto, truck, bus  |

## Lane TOD

The lane_tod table is used for the lanes that reverse direction and the parking lanes that become travel lanes. An ad-hoc field for notes was added for clarity.

Table 5: lane_tod
| lane_tod_id | lane_id | time_day           | timeday_id | lane_num | allowed_uses | notes |
| ---         | ---     | ---                | ---        | ---      | ---          | ---   |
| 531         | 53      | 01111100_0700_0930 | ---        | 3        | all          | Parking lane used for travel (AM Peak)   |
| 532         | 53      | 01111100_1600_1830 | ---        | 3        | all          | Parking lane used for travel (PM Peak)   |
| 501         | 50      | 01111100_0700_0930 | ---        | -1       | all          | Reverses direction of lane from link 6   |
| 612         | 61      | 01111100_0700_0930 | ---        | 0        | none         | Lane used for link 5                     |
| 631         | 63      | 01111100_1600_1830 | ---        | 3        | all          | Parking lane used for travel (PM Peak)   |
| 632         | 63      | 01111100_0700_0930 | ---        | 3        | all          | Parking lane used for travel (AM Peak)   |
| 601         | 60      | 01111100_1600_1830 | ---        | -1       | all          | Reverses direction of lane from link 5   |
| 512         | 51      | 01111100_1600_1830 | ---        | 0        | none         | Lane used for link 6                     |

*Optional fields left blank for this example are: r_barrier, l_barrier, and width
