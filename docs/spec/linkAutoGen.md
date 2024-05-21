## link.schema.json

A link is an edge in a network, defined by the nodes it travels from and to. It may have associated geometry information. Links have three types of attributes:<br>  - Those that define the physical location of the link (e.g., `shape` `information`, `length`, `width`)<br>  - Those that define the directionality of the link: `from_node`, `to_node`<br>  - Those that define properties in the direction of travel: capacity,free flow speed, number of lanes, permitted uses, grade, facility type

**Primary Key:** link_id

**Missing Values:** NaN, 

| Field Name     | Type   | Description                                                                                    | Constraints                                                 | Foreign Key         |
| -------------- | ------ | ---------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------- |
| link_id         | any    | Primary key - could be SharedStreets Reference ID                                              | required: True                                             |                     |
| parent_link_id  | any    | Optional. The parent of this link. For example,for a sidewalk, this is the adjacent road.      |                                                            | .link_id            |
| name            | string | Optional. Street or Path Name                                                                  |                                                            |                     |
| from_node_id    | any    |                                                                                                | required: True                                             | node.node_id        |
| to_node_id      | any    |                                                                                                | required: True                                             | node.node_id        |
| directed        | boolean | Required. Whether the link is directed (travel only occurs from the from_node to the to_node) or undirected. |                                                            |                     |
| geometry_id     | any    | Optional. Foreign key (Link_Geometry table).                                                   |                                                            | geometry.geometry_id |
| geometry        | any    | Optional. Link geometry, in well-known text (WKT) format. Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json |                                                            |                     |
| dir_flag        | integer | Optional. <br>1  shapepoints go from from_node to to_node;<br>-1 shapepoints go in the reverse direction;<br>0  link is undirected or no geometry information is provided. | enum: [-1, 0, 1]                                           |                     |
| length          | number | Optional. Length of the link in long_length units                                              | minimum: 0                                                 |                     |
| grade           | number | % grade, negative is downhill                                                                  | maximum: 100, minimum: -100                                |                     |
| facility_type   | string | Facility type (e.g., freeway, arterial, etc.)                                                  |                                                            |                     |
| capacity        | number | Optional. Capacity (veh / hr / lane)                                                           | minimum: 0                                                 |                     |
| free_speed      | number | Optional. Free flow speed, units defined by config file                                        | minimum: 0, maximum: 200                                   |                     |
| lanes           | integer | Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes. | minimum: 0                                                 |                     |
| bike_facility   | string | Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A at https://nmtdev.ornl.gov/assets/templates/NBN_DataTemplates_final.pdf) | enum: ['unseparated bike lane', 'buffered bike lane', 'separated bike lane', 'counter-flow bike lane', 'paved shoulder', 'shared lane', 'shared use path', 'off-road unpaved trail', 'other', 'none'] |                     |
| ped_facility    | string | Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path  | enum: ['unknown', 'none', 'shoulder', 'sidewalk', 'offstreet_path'] |                     |
| parking         | string | Optional. Type of parking: unknown, none, parallel, angle, other                               | enum: ['unknown', 'none', 'parallel', 'angle', 'other']    |                     |
| allowed_uses    | string | Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated. |                                                            |                     |
| toll            | number | Optional.  Toll on the link, in currency units.                                                |                                                            |                     |
| jurisdiction    | string | Optional.  Owner/operator of the link.                                                         |                                                            |                     |
| row_width       | number | Optional. Width (short_length units) of the entire right-of-way (both directions).             | minimum: 0                                                 |                     |