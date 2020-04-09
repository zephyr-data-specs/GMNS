# offroad\_link

An **offroad\_link** is an **edge** that locates footways (e.g.,
sidewalks, crosswalks) on a map, defined by the two nodes it connects.
The nodes may be different from those used in the road network. For
example, a node in the network representing an intersection may have
four associated pedestrian nodes, one at each corner, where sidewalks
and crosswalks connect. An offroad\_link may have associated geometry,
as defined by a reference to the Link_Geometry table.

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
| link_geom\_id                      | Link_Geometry\_ID    | Optional  | Foreign key (Link_Geometry table)                                                                                                                                                                        |
| assoc\_road\_link_id                     | Link\_ID              | Optional  | For sidewalks, the associated road link (Foreign key, road\_links table)                                                                                                                                   |
| assoc\_node_id                       | Node\_ID              | Optional  | For crosswalks at an intersection, the node for the intersection. (Foreign key, nodes table) |
| Other fields                            | INTEGER, DOUBLE, TEXT | Optional  |                                                                                                                                                                                                            |
  
Note: To facilitate drawing these links and nodes, it is preferred that
    the a\_node be located near the first shapepoint in the physical
    link, and the b\_node be located near the last shapepoint.

## Relationships
![Relationships with the offroad_link table](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/offroad_link.png)