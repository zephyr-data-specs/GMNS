## `node`
  - `description` A list of vertices that locate points on a map. Typically, they will represent intersections, but may also represent other points, such as a transition between divided and undivided highway. Nodes are the endpoints of a link (as opposed to the other type of vertex, location, which is used to represent points along a link)
  - `path` node.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['node_id']
    - `foreignKeys`
      - [1]
        - `fields` ['zone_id']
        - `reference`
          - `resource` zone
          - `fields` ['zone_id']
      - [2]
        - `fields` ['parent_node_id']
        - `reference`
          - `resource` 
          - `fields` ['node_id']
    - `fieldsMatch` subset
  
| name           | type   | description                                                                                                                                    | constraints        | categories                                    |
|:---------------|:-------|:-----------------------------------------------------------------------------------------------------------------------------------------------|:-------------------|:----------------------------------------------|
| node_id        | any    | Primary key                                                                                                                                    | {'required': True} |                                               |
| name           | string |                                                                                                                                                |                    |                                               |
| x_coord        | number | Coordinate system specified in config file (longitude, UTM-easting etc.)                                                                       | {'required': True} |                                               |
| y_coord        | number | Coordinate system specified in config file (latitude, UTM-northing etc.)                                                                       | {'required': True} |                                               |
| z_coord        | number | Optional. Altitude in short_length units.                                                                                                      |                    |                                               |
| node_type      | string | Optional. What it represents (intersection, transit station, park & ride).                                                                     |                    |                                               |
| ctrl_type      | string | Optional. Intersection control type - one of ControlType_Set.                                                                                  |                    | ['none', 'yield', 'stop', '4_stop', 'signal'] |
| zone_id        | any    | Optional. Could be a Transportation Analysis Zone (TAZ) or city, or census tract, or census block.                                             |                    |                                               |
| parent_node_id | any    | Optional. Associated node. For example, if this node is a sidewalk, a parent_nodek_id could represent the intersection  it is associated with. |                    |                                               |