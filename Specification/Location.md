#	location	

A __location__ is a vertex that is associated with a specific location along a link. Locations may be used to represent places where activities occur (e.g., driveways and bus stops). Its attributes are nearly the same as those for a node, except that the location includes an associated link and node, with location specified as distance along the link from the node. The Zone field enables the network to be loaded via locations (similar to what is done in TRANSIMS).

location data dictionary

| Field                                       | Type       | Required?                   | Comment                                                                                                                                 |
| ------------------------------------------- | ---------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| loc\_id | Location\_ID | Required                    | Primary Key                                                                                                                             |
| road\_link\_id                              | Road_Link\_ID   | Conditionally Required (see note) | Foreign Key (from Road\_Link)                                                                                                           |
| offroad\_link\_id                           | offroad\_link\_ID   | Conditionally Required      | A location that is primarily associated with a road\_link may also be associated with a offroad\_link (see note). Foreign key; offroad\_link |
| ref\_node_id                                  | Node\_ID | Required                    | the From node of the link; foreign key (Nodes table)                                                                                    |
| lr                                          | DOUBLE     | Required                    | Linear Reference of the location, measured as distance along the link from the reference node                                           |
| x_coord                                      | DOUBLE     | Optional                    | Derived from Link, Ref\_Node and LR                                                                                                     |
| y_coord                                      | DOUBLE     | Optional                    | Derived from Link, Ref\_Node and LR                                                                                                     |
| z_coord                                      | DOUBLE     | Optional                    | Altitude                                                                                                                                |
| loc\_type                              | TEXT       | Optional                    | What it represents (driveway, bus stop, etc.)                                                                                           |
| zone\_id                                    | Zone\_ID   | Optional                    | Foreign Key, Associated zone                                                                                                            |
| gtfs\_stop\_id                              | TEXT       | Optional                    | For bus stops and transit station entrances, provides a link to the General Transit Feed Specification                                  |
| Other fields (e.g., area, subarea)          | TEXT       | Optional                    |                                                                                                                                         |

Note: If the location is associated with a Road\_Link, the Road\_Link is
    required, and used for the linear reference. In this case, an
    associated Offroad\_link may optionally be used. If the location is
    associated solely with an Offroad\_Link (in cases where a footway is
    not adjacent to a road), then Offroad\_Link is required and becomes
    the basis for the linear reference.  

Examples of cases where both Road\_Link and Offroad\_Link might be
    used: If the location represents a bus stop, and sidewalks are
    represented as Offroad\_Links, then the location will need to be
    associated with both a Road\_Link and an Offroad\_link. This enables
    routing of passengers on transit. Similarly, if both vehicle and
    pedestrian routing are planned, then the locations where the network
    is loaded will be connected to both Road\_Links and Offroad\_Links.

## Relationships
![Relationships with the Location table](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/location.png)