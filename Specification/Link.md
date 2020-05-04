link

A **link** is an edge in a network, defined by the
nodes it travels from and to. It may have associated geometry information. Links have three
types of attributes:

  - Those that define the physical location of the link (e.g., shape information, length,
    width)

  - Those that define the link’s directionality: from\_node, to\_node

  - Those that define properties in the direction of travel: capacity,
    free flow speed, number of lanes, permitted uses, grade, facility type

link data dictionary

| Field                                   | Type                  | Required? | Comment                                                                                                                                                                       |
| --------------------------------------- | --------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| link_id | Link\_ID              | Required  | Primary key – could be SharedStreets Reference ID                                                                                                                             |
| name                                    | TEXT                  | Optional  |                                                                                                                                                                               |
| from\_node_id                              | Node\_ID            | Required  | Foreign key (Nodes table)                                                                                                                                                     |
| to\_node_id                                | Node\_ID            | Required  | Foreign key (Nodes table)                                                                                                                                                     |
| geometry_id | Geometry_id | Optional  | Foreign key (Geometry table). Either the geometry_id OR the geometry is used  |
| geometry                     | WKT    | Optional  | Link shapepoints (well known text)                                                                                                                                            |
|parent_link_id | link_id | Optional | The parent of this link. For example, for a sidewalk, this is the adjacent road.
| dir\_flag                        | INTEGER               | Optional  | 1 = flow follows direction of shapepoints in the geometry (forward); -1 = flow is against shapepoint direction (backward); 0 = link is undirected (e.g., a sidewalk).                                               |
| length  |  DOUBLE | Optional  | Length of the link  |
| grade | DOUBLE  | Optional  |  Percent grade of the link (<0 is down) |
| facility_type | TEXT | Optional | Facility type (e.g., freeway, arterial, etc.) |
| capacity                                | INTEGER               | Optional  | Capacity (veh / hr)                                                                                                                                                           |
| free_speed                               | INTEGER               | Optional  | Free flow speed                                                                                                                                                               |
| lanes                           | INTEGER               | Optional  | Number of lanes in the direction of travel                                                                                                                                       |
| bike_facility                            | TEXT                  | Optional  | Type of bicycle accommodation: Unknown, None, WCL, Bikelane, Cycletrack                                                                                                       |
| ped_facility                             | TEXT                  | Optional  | Type of pedestrian accommodation: Unknown, None, Shoulder, Sidewalk                                                                                                           |
| parking                                 | TEXT                  | Optional  | Type of parking: Unknown, None, Parallel, Angle, Other                                                                                                                        |
| allowed\_uses                           | Use\_Set              | Optional  | Set of allowed uses: SHOULDER, PARKING, WALK, ALL, BIKE, AUTO, HOV2, HOV3, TRUCK, BUS, etc.                                                                                   |
| jurisdiction  | TEXT  | Optional  | Owner/operator of the link  |
| row_width | DOUBLE  | Optional  |  Width of the entire right-of-way (both directions).  | 
| Other fields                            | INTEGER, DOUBLE, TEXT | Optional  | Examples of other fields might include jam density, wave speed, traffic message channel (TMC) identifier, traffic count sensor identifier and location, average daily traffic |
| 


Note on the _lanes_ field: This field is maintained for compatibility with static models, where
    the Lanes table is not used. Here, it is treated as the number of
    permanent lanes (not including turn pockets) open to motor vehicles.
    Therefore, a link which acts solely as a contra-flow bike lane will
    have a number of lanes = 0.
