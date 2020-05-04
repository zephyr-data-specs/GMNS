#	location	

A __location__ is a vertex that is associated with a specific location along a link. Locations may be used to represent places where activities occur (e.g., driveways and bus stops). Its attributes are nearly the same as those for a node, except that the location includes an associated link and node, with location specified as distance along the link from the node. The Zone field enables the network to be loaded via locations (similar to what is done in TRANSIMS).

location data dictionary

| Field                                       | Type       | Required?                   | Comment                                                                                                                                 |
| ------------------------------------------- | ---------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| loc\_id | Location\_ID | Required                    | Primary Key                                                                                                                             |
| link\_id                              | Link\_ID   | Required | Foreign Key (from Link)                                                                                                           |
| ref\_node_id                                  | Node\_ID | Required                    | reference node for linear referencing; foreign key (Nodes table)                                                                                    |
| lr                                          | DOUBLE     | Optional                    | Linear Reference of the location, measured as distance along the link from the reference node                                           |
| x_coord                                      | DOUBLE     | Optional                    | Derived from Link, Ref\_Node and LR                                                                                                     |
| y_coord                                      | DOUBLE     | Optional                    | Derived from Link, Ref\_Node and LR                                                                                                     |
| z_coord                                      | DOUBLE     | Optional                    | Altitude                                                                                                                                |
| loc\_type                              | TEXT       | Optional                    | What it represents (driveway, bus stop, etc.)                                                                                           |
| zone\_id                                    | Zone\_ID   | Optional                    | Foreign Key, Associated zone                                                                                                            |
| gtfs\_stop\_id                              | TEXT       | Optional                    | For bus stops and transit station entrances, provides a link to the General Transit Feed Specification                                  |
| Other fields (e.g., area, subarea)          | TEXT       | Optional                    |                                                                                                                                         |

