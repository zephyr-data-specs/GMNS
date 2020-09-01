#	location	

A __location__ is a vertex that is associated with a specific location along a link. Locations may be used to represent places where activities occur (e.g., driveways and bus stops). Its attributes are nearly the same as those for a node, except that the location includes an associated link and node, with location specified as distance along the link from the node. The Zone field enables the network to be loaded via locations (similar to what is done in TRANSIMS).

location data dictionary

| Field                                       | Type       | Required?                   | Comment                                                                                                                                 |
| ------------------------------------------- | ---------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| loc\_id | Location\_ID | Required                    | Primary Key                                                                                                                             |
| link\_id                              | Link\_ID   | Required | Foreign Key (from Link)                                                                                                           |
| ref\_node_id                                  | Node\_ID | Required                    | reference node for linear referencing; foreign key (Nodes table)                                                                                    |
| lr                                          | DOUBLE     | Required                    | Linear Reference of the location, measured as distance along the link from the reference node                                           |
| x_coord                                      | DOUBLE     | Optional                    | Either provided, or derived from Link, Ref\_Node and LR                                                                                                     |
| y_coord                                      | DOUBLE     | Optional                    | Either provided, or derived from Link, Ref\_Node and LR                                                                                                     |
| z_coord                                      | DOUBLE     | Optional                    | Altitude                                                                                                                                |
| loc\_type                              | TEXT       | Optional                    | What it represents (driveway, bus stop, etc.) OpenStreetMap [map feature names](https://wiki.openstreetmap.org/wiki/Map_Features) are recommended.                                                                                          |
| zone\_id                                    | Zone\_ID   | Optional                    | Foreign Key, Associated zone                                                                                                            |
| gtfs\_stop\_id                              | TEXT       | Optional                    | For bus stops and transit station entrances, provides a link to the General Transit Feed Specification                                  |


Ad hoc fields (e.g., area, subarea) may also be added.

Note on lr: If link geometry exists, it is used; otherwise the link geometry is assumed to be the straight line distance between the from_node and to_node

If x_coord or y_coord are not provided, they are derived from Link Ref\_Node and LR. If x_coord or y_coord are provided, Link Ref\_Node and LR are still required to place the location in the network.
