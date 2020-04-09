# road\_link

A **road\_link** is a directed edge in a network, defined by the
nodes it travels from and to. It may have associated geometry, as
defined by a reference to the [link_geometry](Link_Geometry) table. Links have three
types of attributes:

  - Those that define the physical location of the link, inherited from
    Link_Geometry (e.g., shape information, length,
    width), which can be referenced with the foreign key link_geom_id

  - Those that define the link’s directionality: from\_node, to\_node

  - Those that define properties in the direction of travel: capacity,
    free flow speed, number of lanes, permitted uses, grade, facility type

road\_link data dictionary

| Field                                   | Type                  | Required? | Comment                                                                                                                                                                       |
| --------------------------------------- | --------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| road_link\_id | Link\_ID              | Required  | Primary key – could be SharedStreets Reference ID                                                                                                                             |
| name                                    | TEXT                  | Optional  |                                                                                                                                                                               |
| from\_node_id                              | Node\_ID            | Required  | Foreign key (Nodes table)                                                                                                                                                     |
| to\_node_id                                | Node\_ID            | Required  | Foreign key (Nodes table)                                                                                                                                                     |
| link_geom\_id                      | Link_Geometry\_ID    | Optional  | Foreign key (Link_Geometry table)                                                                                                                                           |
| dir\_flag                        | INTEGER               | Optional  | 1 = flow follows direction of shapepoints in the Link_Geometry (forward); -1 = flow is against shapepoint direction (backward)                                               |
| capacity                                | INTEGER               | Optional  | Capacity (veh / hr)                                                                                                                                                           |
| free_speed                               | INTEGER               | Optional  | Free flow speed                                                                                                                                                               |
| lanes                           | INTEGER               | Optional  | Number of lanes in the direction of travel                                                                                                                                       |
| bike_facility                            | TEXT                  | Optional  | Type of bicycle accommodation: Unknown, None, WCL, Bikelane, Cycletrack                                                                                                       |
| ped_facility                             | TEXT                  | Optional  | Type of pedestrian accommodation: Unknown, None, Shoulder, Sidewalk                                                                                                           |
| parking                                 | TEXT                  | Optional  | Type of parking: Unknown, None, Parallel, Angle, Other                                                                                                                        |
| allowed\_uses                           | Use\_Set              | Optional  | Set of allowed uses: SHOULDER, PARKING, WALK, ALL, BIKE, AUTO, HOV2, HOV3, TRUCK, BUS, etc.                                                                                   |
| Other fields                            | INTEGER, DOUBLE, TEXT | Optional  | Examples of other fields might include jam density, wave speed, traffic message channel (TMC) identifier, traffic count sensor identifier and location, average daily traffic |
| facility\_type                                      | TEXT                  | Optional   | e.g., functional class                                                                                                                               |
| grade                                               | DOUBLE                | Optional   | % grade, negative is downhill                                                                                                   |


Note on the _lanes_ field: This field is maintained for compatibility with static models, where
    the Lanes table is not used. Here, it is treated as the number of
    permanent lanes (not including turn pockets) open to motor vehicles.
    Therefore, a link which acts solely as a contra-flow bike lane will
    have a number of lanes = 0.

## Relationships
![Relationships with the Road_Link table](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/road_link.png)