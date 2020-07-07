# link

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
| directed | boolean | Required | Whether the link is directed (travel only occurs from the from_node to the to_node) or undirected. |
| geometry_id | Geometry_id | Optional  | Foreign key (Geometry table). Either the geometry_id OR the geometry is used  |
| geometry                     | Geometry    | Optional  | Link geometry, specific format could be WKT, GeoJSON, PostGIS geometry datatype                              |
|parent_link_id | link_id | Optional | The parent of this link. For example, for a sidewalk, this is the adjacent road.
| dir\_flag                        | enum               | Optional  | 1 = shapepoints go from from_node to to_node;  -1 shapepoints go in the reverse direction; 0 = link is undirected or no geometry information is provided.                                               |
| length  |  DOUBLE | Optional  | Length of the link  |
| grade | DOUBLE  | Optional  |  Percent grade of the link (<0 is down) |
| facility_type | TEXT | Optional | Facility type (e.g., freeway, arterial, etc.) |
| capacity                                | INTEGER               | Optional  | Capacity (veh / hr / lane)                                                                                                                                                           |
| free_speed                               | INTEGER               | Optional  | Free flow speed                                                                                                                                                               |
| lanes                           | INTEGER               | Optional  | Number of lanes in the direction of travel                                                                                                                                       |
| bike_facility                            | TEXT                  | Optional  | Type of bicycle accommodation: Unknown, None, WCL, Bikelane, Cycletrack                                                                                                       |
| ped_facility                             | TEXT                  | Optional  | Type of pedestrian accommodation: Unknown, None, Shoulder, Sidewalk                                                                                                           |
| parking                                 | TEXT                  | Optional  | Type of parking: Unknown, None, Parallel, Angle, Other                                                                                                                        |
| allowed\_uses                           | Use\_Set              | Optional  | Set of allowed uses: SHOULDER, PARKING, WALK, ALL, BIKE, AUTO, HOV2, HOV3, TRUCK, BUS, etc.                                                                                   |
| jurisdiction  | TEXT  | Optional  | Owner/operator of the link  |
| row_width | DOUBLE  | Optional  |  Width (in feet) of the entire right-of-way (both directions).  | 


Ad hoc fields may also be added. Examples might include jam density, wave speed, traffic message channel (TMC) identifier, traffic count sensor identifier and location, average daily traffic, etc. 

Note on the _lanes_ field: This field is maintained for compatibility with static models, where
    the Lanes table is not used. Here, it is treated as the number of
    permanent lanes (not including turn pockets) open to motor vehicles.  It does not include bike lanes, shoulders or parking lanes.
    Therefore, a link which acts solely as a contra-flow bike lane will
    have a number of lanes = 0.
