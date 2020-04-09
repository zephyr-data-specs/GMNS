# offroad\_link

An **offroad\_link** is an **edge** that locates footways (e.g.,
sidewalks, crosswalks) on a map, defined by the two nodes it connects.
The nodes may be different from those used in the road network. For
example, a node in the network representing an intersection may have
four associated pedestrian nodes, one at each corner, where sidewalks
and crosswalks connect. An offroad\_link may have associated geometry.

Offroad links are used for pedestrian facilities. They do not have
associated lanes or Movements, as bidirectional travel is generally
allowed. Pedestrian travel can be routed by using offroad links and auto
network links. Note that a bicycle/pedestrian shared use path could be
treated as either a road\_link or as an offroad\_link.

offroad\_link data dictionary

| Field                                   | Type                  | Required? | Comment                                                                                                                                                                                                    |
| --------------------------------------- | --------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| offroad_link\_id | Offroad_Link\_ID              | Required  | Primary key                                                                                                                                                                                                |
| name                                    | TEXT                  | Optional  |                                                                                                                                                                                                            |
| a\_node_id                                 | Node\_ID            | Required  | Foreign key (Node table)                                                                                                                                                                             |
| b\_node_id                                 | Node\_ID            | Required  | Foreign key (Node table)                                                                                                                                                                                  |
| geometry                     | WKT    | Optional  | Link shapepoints (well known text)                                                                                                                                            |
| dir\_flag                        | INTEGER               | Optional  | 1 = A->B follows direction of shapepoints in the geometry (forward); -1 = B->A follows shapepoint direction (backward)                                               |
| length  |  DOUBLE | Optional  | Length of the link  |
| grade | DOUBLE  | Optional  |  Percent grade of the link in the A->B direction(<0 is down) |
| assoc\_road\_link_id                     | Link\_ID              | Optional  | For sidewalks, the associated road link (Foreign key, road\_links table)                                                                                                                                   |
| assoc\_node_id                       | Node\_ID              | Optional  | For crosswalks at an intersection, the node for the intersection. (Foreign key, nodes table) |
| allowed\_uses                           | Use\_Set              | Optional  | Set of allowed uses:  WALK, BIKE, etc.                                                                                   |
| jurisdiction  | TEXT  | Optional  | Owner/operator of the link  |
| row_width | DOUBLE  | Optional  |  Width of the entire right-of-way   | 
| Other fields                            | INTEGER, DOUBLE, TEXT | Optional  |                                                                                                                                                                                                            |
  
Note: To facilitate drawing these links and nodes, it is preferred that
    the a\_node be located near the first shapepoint in the physical
    link, and the b\_node be located near the last shapepoint.

## Relationships
![Relationships with the offroad_link table](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/offroad_link.png)
