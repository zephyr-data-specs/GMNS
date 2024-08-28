# Case 2: Pedestrian / bicycle access to destinations on a node-link network
 
This use case requires node-link network that includes both streets and relevant off-road paths.  It models access to destinations for pedestrian and bicycls condidering link availability, distannce, and some mesasure of traffic stress.  This is the model for the Cambridge Multimodal Network [example](https://github.com/zephyr-data-specs/GMNS/tree/develop/examples/Cambridge_Multimodal_Network)
 
The config table is needed because it contains the units for the other tables, as well as the coordinate reference system (CRS)
 
Table   Config table for case 2
 
| **name** | **type** | **description** | **needed** | **comment** |
| --- | --- | --- | --- | --- |
| dataset_name | any | Name used to describe this GMNS network | Yes |     |
| short_length | any | Length unit used for lane/ROW widths and linear references for segments, locations, etc. along links | Maybe  | Needed if sidewalk or bike lane/path width is part of the evaluation |
| long_length | any | Length unit used for link lengths | Yes | Typically, miles or km |
| speed | any | Units for speed. Usually long_length units per hour | Yes | Typically, mph or kph |
| crs | any | Coordinate system used for geometry data in this dataset. Preferably a string that can be accepted by pyproj (e.g., EPSG code or proj string) | Yes | Typically, WGS 84 (EPSG:4326) |
| geometry_field_format | any | The format used for geometry fields in the dataset. For example, WKT for files stored as plaintext | Yes | Typically, wkt |
| currency | any | Currency used in toll fields | No |Presumably, bike and ped facilities do not have tolls |
| version_number | number | The version of the GMNS spec to which this dataset conforms | Yes |     |
| id_type | string | The type of primary key IDs for interopability (node_id, zone_id, etc.). May be enforced by user, database schema, or downstream software. Must be either string or integer. | {'enum': \['string', 'integer'\]} | Depends on whether the routing software needs primary keys of a particular type |
 
The node table is needed because it locates the network on the Earth and indicates how links are connected.
 
Table   Node table for case 2
 
| **name** | **type** | **description** | **needed** | **comments** |
| --- | --- | --- | --- | --- |
| node_id | any | Primary key | Yes |     |
| name | string |     | No  |     |
| x_coord | number | Coordinate system specified in config file (longitude, UTM-easting etc.) | Yes | To locate the nodes on a map |
| y_coord | number | Coordinate system specified in config file (latitude, UTM-northing etc.) | Yes | To locate the nodes on a map |
| z_coord | number | Optional. Altitude in short_length units. | No  | This example network is fairly flat. z_coord could be used if modeling hilly terrain    |
| node_type | string | Optional. What it represents (intersection, transit station, park & ride). | Maybe | Depends on the routing algorithm. Some may require centroid nodes to be labeled as such. |
| ctrl_type | string | Optional. Intersection control type - one of ControlType_Set. | Maybe | Not used in this example. Could be used if control_type (signal, stop, etc) is important for the routing algorithm     |
| zone_id | any | Optional. Could be a Transportation Analysis Zone (TAZ) or city, or census tract, or census block. | No  |     |
| parent_node_id | any | Optional. Associated node. For example, if this node is a sidewalk, a parent_nodek_id could represent the intersection it is associated with. | No  |     |
 
The link table is needed for routing.  It contains several user defined fields, beginning with u_, used to calculate the bicycle and pedestrian impedance,  
 
Table   Link table for case 2
 
| **name** | **type** | **description** | **needed** | **comments** |
| --- | --- | --- | --- | --- |
| link_id | any | Primary key - could be SharedStreets Reference ID | Yes |     |
| name | string | Optional. Street or Path Name | Yes, for some | Used to identify the major roads     |
| from_node_id | any | Required. Origin Node | Yes |     |
| to_node_id | any | Required. Destination Node | Yes |     |
| directed | boolean | Required. Whether the link is directed (travel only occurs from the from_node to the to_node) or undirected. | Yes |     |
| geometry_id | any | Optional. Foreign key (Link_Geometry table). | Maybe |     |
| geometry | any | Optional. Link geometry, in well-known text (WKT) format. Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json | Maybe | Either geometry_id or geometry is needed if the links are to be displayed using true shapes (and not as a stick network). |
| parent_link_id | any | Optional. The parent of this link. For example,for a sidewalk, this is the adjacent road. | No  | Not used in this example, but could be used to associate sidewalks with their adjacent streets    |
| dir_flag | integer | Optional.  <br>1 shapepoints go from from_node to to_node;  <br>\-1 shapepoints go in the reverse direction;  <br>0 link is undirected or no geometry information is provided. | No  |     |
| length | number | Optional. Length of the link in long_length units | Yes | Can by computed by the GIS based on the geometry |
| grade | number | % grade, negative is downhill | No  | Could be useful in a hilly network    |
| facility_type | string | Facility type (e.g., freeway, arterial, etc.) | Yes  | Since few links had directly-measured traffic volumes, facility_type was used as a proxy for traffic volume, as an input to the traffic stress calculation    |
| capacity | number | Optional. Saturation capacity (passenger car equivalents / hr / lane) | No | Refers to motor vehicle capacity.  Assuming bike/ped is uncapacitated |
| free_speed | number | Optional. Free flow speed, units defined by config file | Maybe | Motor vehicle speed, could go into the traffic stress computation |
| lanes | integer | Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes. | Yes | Motor-vehicle lanes could go into the traffic stress computation |
| bike_facility | string | Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A at https://nmtdev.ornl.gov/assets/templates/NBN_DataTemplates_final.pdf) | Yes  | Important for this example    |
| ped_facility | string | Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path | No  |     |
| parking | string | Optional. Type of parking: unknown, none, parallel, angle, other | Yes  | Important for this example    |
| allowed_uses | string | Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated. | Yes  | Indicates whether bicycles or pedestrians can use the link at all    |
| toll | number | Optional. Toll on the link, in currency units. | No  | No tolls in this network    |
| jurisdiction | string | Optional. Owner/operator of the link. | No  |     |
| row_width | number | Optional. Width (short_length units) of the entire right-of-way (both directions). | No  |     |
| u_bike_speed | number | User defined. Average bicycle speed as adjusted depending on the attractiveness of the facility | Yes | More attractive facilities are "faster", less attractive are "slower".  Sidewalks, where bikes may be walked, are given a walking speed | 
| u_walk_speed | number | User defined. Average walking speed as adjusted depending on the attractiveness of the facility | Yes | More attractive facilities are "faster", less attractive are "slower".  | 
| u_bike_travel_time | number | User defined. Calculated based on speed and link length. | Yes  | Used by the GIS accessibility calculator    |
| u_walk_travel_time | number | User defined. Calculated based on speed and link length. | Yes  | Used by the GIS accessibility calculator      |
---------------------------------