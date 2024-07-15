## `location`
  - `description` A location is a vertex that is associated with a specific location along a link. Locations may be used to represent places where activities occur (e.g., driveways and bus stops). Its attributes are nearly the same as those for a node, except that the location includes an associated link and node, with location specified as distance along the link from the node.
  - `path` location.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['loc_id']
    - `foreignKeys`
      - [1]
        - `fields` ['link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
      - [2]
        - `fields` ['ref_node_id']
        - `reference`
          - `resource` node
          - `fields` ['node_id']
    - `fieldsMatch` subset
  
| name         | type   | description                                                                                                                                                                                                                                               | constraints                      |
|:-------------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------|
| loc_id       | any    | Primary key. Location ID.                                                                                                                                                                                                                                 | {'required': True}               |
| link_id      | any    | Required. Road Link ID. Foreign Key from Road_Link.                                                                                                                                                                                                       | {'required': True}               |
| ref_node_id  | any    | Required. The From node of the link. Foreign Key from Node.                                                                                                                                                                                               | {'required': True}               |
| lr           | number | Required. Linear Reference of the location, measured as distance in short_length units along the link from the reference node.  If link_geometry exists, it is used. Otherwise, link geometry is assumed to be a crow-fly distance from A node to B node. | {'required': True, 'minimum': 0} |
| x_coord      | number | Optional. Either provided, or derived from Link, Ref_Node and LR.                                                                                                                                                                                         |                                  |
| y_coord      | number | Optional. Either provided, or derived from Link, Ref_Node and LR.                                                                                                                                                                                         |                                  |
| z_coord      | number | Optional. Altitude in short_length units.                                                                                                                                                                                                                 |                                  |
| loc_type     | string | Optional. What it represents (driveway, bus stop, etc.) OpenStreetMap map feature names are recommended.                                                                                                                                                  |                                  |
| zone_id      | any    | Optional. Foreign Key, Associated zone                                                                                                                                                                                                                    |                                  |
| gtfs_stop_id | string | Optional. Foreign Key to GTFS data. For bus stops and transit station entrances, provides a link to the General Transit Feed Specification.                                                                                                               |                                  |