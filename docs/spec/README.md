# `gmns` General Modeling Network Specification (GMNS)
- `description` The General Modeling Network Specification (GMNS) defines a common machine (and human) readable format for sharing routable road network files. It is designed to be used in multi-modal static and dynamic transportation planning and operations models.
- `homepage` https://github.com/zephyr-data-specs/GMNS
- `version` 0.96
## `link`
  
- `description` A link is an edge in a network, defined by the nodes it travels from and to. It may have associated geometry information. Links have three types of attributes:<br>  - Those that define the physical location of the link (e.g., `shape` `information`, `length`, `width`)<br>  - Those that define the link's directionality: `from_node`, `to_node`<br>  - Those that define properties in the direction of travel: capacity, free flow speed, number of lanes, permitted uses, grade, facility type
  - `path` link.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['link_id']
    - `foreignKeys`
      - [1]
        - `fields` ['from_node_id']
        - `reference`
          - `resource` node
          - `fields` ['node_id']
      - [2]
        - `fields` ['to_node_id']
        - `reference`
          - `resource` node
          - `fields` ['node_id']
      - [3]
        - `fields` ['geometry_id']
        - `reference`
          - `resource` geometry
          - `fields` ['geometry_id']
      - [4]
        - `fields` ['parent_link_id']
        - `reference`
          - `resource` 
          - `fields` ['link_id']
    - `fieldsMatch` subset
### `link_id`
  
- `description` Primary key - could be SharedStreets Reference ID
  - `type` any
  - `constraints`:
    - `required` True
### `name`
  
- `description` Optional. Street or Path Name
  - `type` string
### `from_node_id`
  
- `description` Required. Origin Node
  - `type` any
  - `constraints`:
    - `required` True
### `to_node_id`
  
- `description` Required. Destination Node
  - `type` any
  - `constraints`:
    - `required` True
### `directed`
  
- `description` Required. Whether the link is directed (travel only occurs from the from_node to the to_node) or undirected.
  - `type` boolean
  - `constraints`:
    - `required` True
### `geometry_id`
  
- `description` Optional. Foreign key (Link_Geometry table).
  - `type` any
### `geometry`
  
- `description` Optional. Link geometry, in well-known text (WKT) format. Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json
  - `type` any
### `parent_link_id`
  
- `description` Optional. The parent of this link. For example,for a sidewalk, this is the adjacent road.
  - `type` any
### `dir_flag`
  
- `description` Optional. <br>1  shapepoints go from from_node to to_node;<br>-1 shapepoints go in the reverse direction;<br>0  link is undirected or no geometry information is provided.
  - `type` integer
### `length`
  
- `description` Optional. Length of the link in long_length units
  - `type` number
  - `constraints`:
### `grade`
  
- `description` % grade, negative is downhill
  - `type` number
  - `constraints`:
    - `maximum` 100
    - `minimum` -100
### `facility_type`
  
- `description` Facility type (e.g., freeway, arterial, etc.)
  - `type` string
### `capacity`
  
- `description` Optional. Saturation capacity (passenger car equivalents / hr / lane)
  - `type` number
  - `constraints`:
### `free_speed`
  
- `description` Optional. Free flow speed, units defined by config file
  - `type` number
  - `constraints`:
    - `maximum` 200
### `lanes`
  
- `description` Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes.
  - `type` integer
  - `constraints`:
### `bike_facility`
  
- `description` Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A) See https://data.transportation.gov/stories/s/National-Bicycle-Network/88zh-3rqb/
  - `type` string
### `ped_facility`
  
- `description` Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path
  - `type` string
### `parking`
  
- `description` Optional. Type of parking: unknown, none, parallel, angle, other
  - `type` string
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `toll`
  
- `description` Optional.  Toll on the link, in currency units.
  - `type` number
### `jurisdiction`
  
- `description` Optional.  Owner/operator of the link.
  - `type` string
### `row_width`
  
- `description` Optional. Width (short_length units) of the entire right-of-way (both directions).
  - `type` number
  - `constraints`:
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
### `node_id`
  
- `description` Primary key
  - `type` any
  - `constraints`:
    - `required` True
### `name`
  - `type` string
### `x_coord`
  
- `description` Coordinate system specified in config file (longitude, UTM-easting etc.)
  - `type` number
  - `constraints`:
    - `required` True
### `y_coord`
  
- `description` Coordinate system specified in config file (latitude, UTM-northing etc.)
  - `type` number
  - `constraints`:
    - `required` True
### `z_coord`
  
- `description` Optional. Altitude in short_length units.
  - `type` number
### `node_type`
  
- `description` Optional. What it represents (intersection, transit station, park & ride).
  - `type` string
### `ctrl_type`
  
- `description` Optional. Intersection control type - one of ControlType_Set.
  - `type` string
### `zone_id`
  
- `description` Optional. Could be a Transportation Analysis Zone (TAZ) or city, or census tract, or census block.
  - `type` any
### `parent_node_id`
  
- `description` Optional. Associated node. For example, if this node is a sidewalk, a parent_nodek_id could represent the intersection  it is associated with.
  - `type` any
## `geometry`
  
- `description` The geometry is an optional file that contains geometry information (shapepoints) for a line object. It is similar to Geometries in the SharedStreets reference system. The specification also allows for geometry information to be stored directly on the link table.
  - `path` geometry.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['geometry_id']
    - `fieldsMatch` subset
### `geometry_id`
  
- `description` Primary key - could be SharedStreets Geometry ID
  - `type` any
  - `constraints`:
    - `required` True
### `geometry`
  
- `description` Link geometry, in well-known text (WKT) format.  Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json.
  - `type` any
## `lane`
  
- `description` The lane file allocates portions of the physical right-of-way that might be used for travel. It might be a travel lane, bike lane, or a parking lane. Lanes only are included in directed links; undirected links are assumed to have no lane controls or directionality. If a lane is added, dropped, or changes properties along the link, those changes are recorded on the `segment_link` table. Lanes are numbered sequentially, starting at either the centerline (two-way street) or the left shoulder (one-way street or divided highway with two centerlines).
  - `path` lane.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['lane_id']
    - `foreignKeys`
      - [1]
        - `fields` ['link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
    - `fieldsMatch` subset
### `lane_id`
  
- `description` Primary key
  - `type` any
  - `constraints`:
    - `required` True
### `link_id`
  
- `description` Required. Foreign key to link table.
  - `type` any
  - `constraints`:
    - `required` True
### `lane_num`
  
- `description` Required. e.g., -1, 1, 2 (use left-to-right numbering). By convention, the left-most through lane is 1. Left-turn lanes have negative numbers
  - `type` integer
  - `constraints`:
    - `required` True
    - `minimum` -10
    - `maximum` 10
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `r_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
  - `type` string
### `l_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
  - `type` string
### `width`
  
- `description` Optional. Width of the lane, short_length units.
  - `type` number
  - `constraints`:
## `link_tod`
  
- `description` Handles day-of-week and time-of-day restrictions on links
  - `path` link_tod.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['link_tod_id']
    - `foreignKeys`
      - [1]
        - `fields` ['link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
    - `fieldsMatch` subset
### `link_tod_id`
  
- `description` Primary key
  - `type` any
  - `constraints`:
    - `required` True
### `link_id`
  
- `description` Required. Foreign key, link table
  - `type` any
  - `constraints`:
    - `required` True
### `timeday_id`
  
- `description` Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
  - `type` any
### `time_day`
  
- `description` Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
  - `type` string
### `capacity`
  
- `description` Optional.Saturation capacity (pce / hr / lane)
  - `type` number
  - `constraints`:
### `free_speed`
  
- `description` Optional. Free flow speed in long_distance units per hour 
  - `type` number
  - `constraints`:
    - `maximum` 200
### `lanes`
  
- `description` Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes.
  - `type` integer
  - `constraints`:
### `bike_facility`
  
- `description` Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template Table 1-A.  See https://data.transportation.gov/stories/s/National-Bicycle-Network/88zh-3rqb/
  - `type` string
### `ped_facility`
  
- `description` Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path
  - `type` string
### `parking`
  
- `description` Optional. Type of parking: unknown, none, parallel, angle, other
  - `type` string
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `toll`
  
- `description` toll in currency units.
  - `type` number
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
### `loc_id`
  
- `description` Primary key. Location ID.
  - `type` any
  - `constraints`:
    - `required` True
### `link_id`
  
- `description` Required. Road Link ID. Foreign Key from Road_Link.
  - `type` any
  - `constraints`:
    - `required` True
### `ref_node_id`
  
- `description` Required. The From node of the link. Foreign Key from Node.
  - `type` any
  - `constraints`:
    - `required` True
### `lr`
  
- `description` Required. Linear Reference of the location, measured as distance in short_length units along the link from the reference node.  If link_geometry exists, it is used. Otherwise, link geometry is assumed to be a crow-fly distance from A node to B node.
  - `type` number
  - `constraints`:
    - `required` True
### `x_coord`
  
- `description` Optional. Either provided, or derived from Link, Ref_Node and LR.
  - `type` number
### `y_coord`
  
- `description` Optional. Either provided, or derived from Link, Ref_Node and LR.
  - `type` number
### `z_coord`
  
- `description` Optional. Altitude in short_length units.
  - `type` number
### `loc_type`
  
- `description` Optional. What it represents (driveway, bus stop, etc.) OpenStreetMap map feature names are recommended.
  - `type` string
### `zone_id`
  
- `description` Optional. Foreign Key, Associated zone
  - `type` any
### `gtfs_stop_id`
  
- `description` Optional. Foreign Key to GTFS data. For bus stops and transit station entrances, provides a link to the General Transit Feed Specification.
  - `type` string
## `movement`
  
- `description` Describes how inbound and outbound links connect at an intersection.
  - `path` movement.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['mvmt_id']
    - `foreignKeys`
      - [1]
        - `fields` ['node_id']
        - `reference`
          - `resource` node
          - `fields` ['node_id']
      - [2]
        - `fields` ['ib_link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
      - [3]
        - `fields` ['ob_link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
    - `fieldsMatch` subset
### `mvmt_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `node_id`
  
- `description` The node representing the junction.
  - `type` any
  - `constraints`:
    - `required` True
### `name`
  
- `description` Optional.
  - `type` string
### `ib_link_id`
  
- `description` Inbound link id.
  - `type` any
  - `constraints`:
    - `required` True
### `start_ib_lane`
  
- `description` Innermost lane number the movement applies to at the inbound end.
  - `type` integer
### `end_ib_lane`
  
- `description` Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.
  - `type` integer
### `ob_link_id`
  
- `description` Outbound link id.
  - `type` any
  - `constraints`:
    - `required` True
### `start_ob_lane`
  
- `description` Innermost lane number the movement applies to at the outbound end.
  - `type` integer
### `end_ob_lane`
  
- `description` Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.
  - `type` integer
### `type`
  
- `description` Optional. Describes the type of movement (left, right, thru, etc.).
  - `type` string
  - `constraints`:
    - `required` True
### `penalty`
  
- `description` Turn penalty (seconds)
  - `type` number
### `capacity`
  
- `description` Saturation capacity in passenger car equivalents per hour.
  - `type` number
### `ctrl_type`
  
- `description` Optional. .
  - `type` string
### `mvmt_code`
  
- `description` Optional. Movement code (e.g., SBL).  Syntax is DDTN, where DD is the direction (e.g., SB, NB, EB, WB, NE, NW, SE, SW). T is the turning movement (e.g., R, L, T) and N is an optional turning movement number (e.g., distinguishing between bearing right and a sharp right at a 6-way intersection)
  - `type` string
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `geometry`
  
- `description` Optional. Movement geometry, in well-known text (WKT) format. Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json
  - `type` any
## `movement_tod`
  
- `description` Handles day-of-week and time-of-day restrictions on movements.
  - `path` movement_tod.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['mvmt_tod_id']
    - `foreignKeys`
      - [1]
        - `fields` ['mvmt_id']
        - `reference`
          - `resource` movement
          - `fields` ['mvmt_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
      - [3]
        - `fields` ['ib_link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
      - [4]
        - `fields` ['ob_link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
    - `fieldsMatch` subset
### `mvmt_tod_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `mvmt_id`
  
- `description` The referenced movement.
  - `type` any
  - `constraints`:
    - `required` True
### `time_day`
  
- `description` Time of day in XXXXXXXX_HHMM_HHMM format, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
  - `type` string
### `timeday_id`
  
- `description` Time of day set. Used if times-of-day are defined on the time_set_definitions table
  - `type` any
### `ib_link_id`
  
- `description` Inbound link id.
  - `type` any
  - `constraints`:
    - `required` True
### `start_ib_lane`
  
- `description` Innermost lane number the movement applies to at the inbound end.
  - `type` integer
### `end_ib_lane`
  
- `description` Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.
  - `type` integer
### `ob_link_id`
  
- `description` Outbound link id.
  - `type` any
  - `constraints`:
    - `required` True
### `start_ob_lane`
  
- `description` Innermost lane number the movement applies to at the outbound end.
  - `type` integer
### `end_ob_lane`
  
- `description` Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.
  - `type` integer
### `type`
  
- `description` Optional. Describes the type of movement (left, right, thru, etc.).
  - `type` string
  - `constraints`:
    - `required` True
### `penalty`
  
- `description` Turn penalty (seconds)
  - `type` number
### `capacity`
  
- `description` Saturation capacity in passenger car equivalents per hour.
  - `type` number
### `ctrl_type`
  
- `description` Optional. .
  - `type` any
### `mvmt_code`
  
- `description` Optional. Movement code (e.g., SBL).  Syntax is DDTN, where DD is the direction (e.g., SB, NB, EB, WB, NE, NW, SE, SW). T is the turning movement (e.g., R, L, T) and N is an optional turning movement number (e.g., distinguishing between bearing right and a sharp right at a 6-way intersection)
  - `type` string
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
## `use_definition`
  
- `description` The Use_Definition file defines the characteristics of each vehicle type or non-travel purpose (e.g., a shoulder or parking lane). A two-way left turn lane (TWLTL) is also a use.
  - `path` use_definition.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['use']
    - `fieldsMatch` subset
### `use`
  
- `description` Primary key
  - `type` string
  - `constraints`:
    - `required` True
### `persons_per_vehicle`
  
- `description` Required.
  - `type` number
  - `constraints`:
    - `required` True
### `pce`
  
- `description` Required. Passenger car equivalent.
  - `type` number
  - `constraints`:
    - `required` True
### `special_conditions`
  
- `description` Optional.
  - `type` string
### `description`
  
- `description` Optional 
  - `type` string
## `use_group`
  
- `description` Defines groupings of uses, to reduce the size of the allowed_uses lists in the other tables.
  - `path` use_group.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['use_group']
    - `fieldsMatch` subset
### `use_group`
  
- `description` Primary key.
  - `type` string
  - `constraints`:
    - `required` True
### `uses`
  
- `description` Comma-separated list of uses.
  - `type` string
  - `constraints`:
    - `required` True
### `description`
  
- `description` Optional.
  - `type` string
## `time_set_definitions`
  
- `description` The time_set_definitions file is an optional representation of time-of-day and day-of-week sets to enable time restrictions through `_tod` files.
  - `path` time_set_definitions.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['timeday_id']
    - `fieldsMatch` subset
### `timeday_id`
  
- `description` Primary key.Primary key, similar to `service_id` in GTFS. Unique name of the time of day. Preferable legible rather than a number.
  - `type` any
  - `constraints`:
    - `required` True
### `monday`
  
- `description` Required. Whether Mondays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `tuesday`
  
- `description` Required. Whether Tuesdays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `wednesday`
  
- `description` Required. Whether Wednesdays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `thursday`
  
- `description` Required. Whether Thursdays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `Friday`
  
- `description` Required. Whether Fridays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `saturday`
  
- `description` Required. Whether Saturdays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `sunday`
  
- `description` Required. Whether Sundays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `holiday`
  
- `description` Required. Whether holidays are included.
  - `type` boolean
  - `constraints`:
    - `required` True
### `start_time`
  
- `description` Required. Start time in HH:MM format.
  - `type` time
  - `constraints`:
    - `required` True
### `end_time`
  
- `description` Required. End  time in HH:MM format.
  - `type` time
  - `constraints`:
    - `required` True
## `segment`
  
- `description` A portion of a link defined by `link_id`,`ref_node_id`, `start_lr`, and `end_lr`. Values in the segment will override they value specified in the link table. When one segment is fully contained within another, its value prevails.
  - `path` segment.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['segment_id']
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
### `segment_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `link_id`
  
- `description` Required. Foreign key to road_links. The link that the segment is located on.
  - `type` any
  - `constraints`:
    - `required` True
### `ref_node_id`
  
- `description` Required. Foreign key to node where distance is 0.
  - `type` any
  - `constraints`:
    - `required` True
### `start_lr`
  
- `description` Required. Distance from `ref_node_id` in short_length units.
  - `type` number
  - `constraints`:
    - `required` True
### `end_lr`
  
- `description` Required. Distance from `ref_node_id`in short_length units.
  - `type` number
  - `constraints`:
    - `required` True
### `grade`
  
- `description` % grade, negative is downhill
  - `type` number
  - `constraints`:
    - `maximum` 100
    - `minimum` -100
### `capacity`
  
- `description` Optional. Saturation capacity (pce/hr/ln)
  - `type` number
  - `constraints`:
### `free_speed`
  
- `description` Optional. Free flow speed, units defined by config file
  - `type` number
  - `constraints`:
    - `maximum` 200
### `lanes`
  
- `description` Optional. Number of lanes in the direction of travel (must be consistent with link lanes + lanes added).
  - `type` integer
### `l_lanes_added`
  
- `description` Optional. # of lanes added on the left of the road link (negative indicates a lane drop).
  - `type` integer
### `r_lanes_added`
  
- `description` Optional. # of lanes added on the right of the road link (negative indicates a lane drop).
  - `type` integer
### `bike_facility`
  
- `description` Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A) See https://data.transportation.gov/stories/s/National-Bicycle-Network/88zh-3rqb/
  - `type` string
### `ped_facility`
  
- `description` Optional. Type of pedestrian accommodation:unknown,none,shoulder,sidewalk,offstreet_path.
  - `type` string
### `parking`
  
- `description` Optional. Type of parking: unknown,none,shoulder,sidewalk,offstreet_path.
  - `type` string
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `toll`
  
- `description` Optional.  Toll on the segment, in currency units.
  - `type` number
### `jurisdiction`
  
- `description` Optional. Optional.  Owner/operator of the segment.
  - `type` string
### `row_width`
  
- `description` Optional. Width (short_length units) of the entire right-of-way (both directions).
  - `type` number
  - `constraints`:
## `segment_lane`
  
- `description` Defines added and dropped lanes, and changes to lane parameters. If a lane is added, it has no parent. If it is changed or dropped, the parent_lane_id field keys to the associated lane on the lane table.
  - `path` segment_lane.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['segment_lane_id']
    - `foreignKeys`
      - [1]
        - `fields` ['segment_id']
        - `reference`
          - `resource` segment
          - `fields` ['segment_id']
    - `fieldsMatch` subset
### `segment_lane_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `segment_id`
  
- `description` Required. Foreign key to the associated segment.
  - `type` any
  - `constraints`:
    - `required` True
### `lane_num`
  
- `description` Required. -1, 1, 2 (use left-to-right numbering). 0 signifies a lane that is dropped on the segment.
  - `type` integer
  - `constraints`:
    - `required` True
    - `minimum` -10
    - `maximum` 10
### `parent_lane_id`
  
- `description` Optional. If a lane drops or changes characteristics on the segment, the lane_id for that lane.
  - `type` any
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `r_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right (default is none)
  - `type` string
### `l_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the left (default is none)
  - `type` string
### `width`
  
- `description` Optional. Width of the lane (short_length units)
  - `type` number
  - `constraints`:
## `signal_controller`
  
- `description` The signal controller is associated with an intersection or a cluster of intersections.
  - `path` signal_controller.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['controller_id']
    - `fieldsMatch` subset
### `controller_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
## `signal_coordination`
  
- `description` Establishes coordination for several signal controllers, associated with a timing_plan.
  - `path` signal_coordination.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['coordination_id']
    - `foreignKeys`
      - [1]
        - `fields` ['timing_plan_id']
        - `reference`
          - `resource` signal_timing_plan
          - `fields` ['timing_plan_id']
      - [2]
        - `fields` ['controller_id']
        - `reference`
          - `resource` signal_controller
          - `fields` ['controller_id']
      - [3]
        - `fields` ['coord_contr_id']
        - `reference`
          - `resource` signal_controller
          - `fields` ['controller_id']
    - `fieldsMatch` subset
### `coordination_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `timing_plan_id`
  
- `description` Required. Foreign key (Signal_timing_plan table).
  - `type` any
  - `constraints`:
    - `required` True
### `controller_id`
  
- `description` Required. Foreign key (signal_controller table).
  - `type` any
  - `constraints`:
    - `required` True
### `coord_contr_id`
  
- `description` Optional. For coordinated signals, the master signal controller for coordination.
  - `type` any
### `coord_phase`
  
- `description` Optional. For coordinated signals, the phase at which coordination starts (time 0).
  - `type` integer
  - `constraints`:
    - `maximum` 32
### `coord_ref_to`
  
- `description` Optional. For coordinated signals, the part of the phase where coordination starts: begin_of_green, begin_of_yellow, begin_of_red.
  - `type` string
### `offset`
  
- `description` Optional. Offset in seconds.
  - `type` number
  - `constraints`:
## `signal_phase_mvmt`
  
- `description` Associates Movements and pedestrian Links (e.g., crosswalks) with signal phases. A signal phase may be associated with several movements. A Movement may also run on more than one phase.
  - `path` signal_phase_mvmt.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['signal_phase_mvmt_id']
    - `foreignKeys`
      - [1]
        - `fields` ['timing_phase_id']
        - `reference`
          - `resource` signal_timing_phase
          - `fields` ['timing_phase_id']
      - [2]
        - `fields` ['mvmt_id']
        - `reference`
          - `resource` movement
          - `fields` ['mvmt_id']
      - [3]
        - `fields` ['link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
    - `fieldsMatch` subset
### `signal_phase_mvmt_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `timing_phase_id`
  
- `description` Associated entry in the timing phase table.
  - `type` any
  - `constraints`:
    - `required` True
### `mvmt_id`
  
- `description` Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required.
  - `type` any
### `link_id`
  
- `description` Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required.
  - `type` any
### `protection`
  
- `description` Optional. Indicates whether the phase is protected, permitted, or right turn on red.
  - `type` string
## `signal_timing_plan`
  
- `description` For signalized nodes, establishes timing plans.
  - `path` signal_timing_plan.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['timing_plan_id']
    - `foreignKeys`
      - [1]
        - `fields` ['controller_id']
        - `reference`
          - `resource` signal_controller
          - `fields` ['controller_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
    - `fieldsMatch` subset
### `timing_plan_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `controller_id`
  
- `description` Required. Foreign key (signal_controller table).
  - `type` any
  - `constraints`:
    - `required` True
### `timeday_id`
  
- `description` Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
  - `type` any
### `time_day`
  
- `description` Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
  - `type` any
### `cycle_length`
  
- `description` Cycle length in seconds.
  - `type` number
  - `constraints`:
    - `maximum` 600
## `signal_timing_phase`
  
- `description` For signalized nodes, provides signal timing and establishes phases that may run concurrently.
  - `path` signal_timing_phase.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['timing_phase_id']
    - `foreignKeys`
      - [1]
        - `fields` ['timing_plan_id']
        - `reference`
          - `resource` signal_timing_plan
          - `fields` ['timing_plan_id']
    - `fieldsMatch` subset
### `timing_phase_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `timing_plan_id`
  
- `description` Foreign key; connects to a timing_plan associated with a controller.
  - `type` any
### `signal_phase_num`
  
- `description` Signal phase number. Typically the NEMA phase number.
  - `type` integer
  - `constraints`:
    - `required` True
### `min_green`
  
- `description` The minimum green time in seconds for an actuated signal. Green time in seconds for a fixed time signal.
  - `type` number
  - `constraints`:
### `max_green`
  
- `description` Optional.The maximum green time in seconds for an actuated signal; the default is minimum green plus one extension
  - `type` number
  - `constraints`:
### `extension`
  
- `description` Optional. The number of seconds the green time is extended each time vehicles are detected.
  - `type` number
  - `constraints`:
    - `maximum` 120
### `clearance`
  
- `description` Yellow interval plus all red interval
  - `type` number
  - `constraints`:
    - `maximum` 120
### `walk_time`
  
- `description` If a pedestrian phase exists, the walk time in seconds
  - `type` number
  - `constraints`:
    - `maximum` 120
### `ped_clearance`
  
- `description` If a pedestrian phase exists, the flashing don't walk time.
  - `type` number
  - `constraints`:
    - `maximum` 120
### `ring`
  
- `description` Required. Phases that may operate sequentially. With dual rings, two non-conflicting phases may operate at the same time
  - `type` integer
  - `constraints`:
    - `required` True
    - `maximum` 12
### `barrier`
  
- `description` Required. Set of phases in both rings that must end at the same time
  - `type` integer
  - `constraints`:
    - `required` True
    - `maximum` 12
### `position`
  
- `description` Required. Position.
  - `type` integer
  - `constraints`:
    - `required` True
## `signal_detector`
  
- `description` A signal detector is associated with a controller, a phase and a group of lanes.
  - `path` signal_detector.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['detector_id']
    - `foreignKeys`
      - [1]
        - `fields` ['controller_id']
        - `reference`
          - `resource` signal_controller
          - `fields` ['controller_id']
      - [2]
        - `fields` ['link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
      - [3]
        - `fields` ['ref_node_id']
        - `reference`
          - `resource` node
          - `fields` ['node_id']
    - `fieldsMatch` subset
### `detector_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `controller_id`
  
- `description` Required. Foreign key to signal_controller table.
  - `type` any
  - `constraints`:
    - `required` True
### `signal_phase_num`
  
- `description` Required. Number of the associated phase.
  - `type` integer
  - `constraints`:
    - `required` True
### `link_id`
  
- `description` Foreign key. The link covered by the detector.
  - `type` any
  - `constraints`:
    - `required` True
### `start_lane`
  
- `description` Left-most lane covered by the detector.
  - `type` integer
  - `constraints`:
    - `required` True
### `end_lane`
  
- `description` Right-most lane covered by the detector (blank if only one lane).
  - `type` integer
### `ref_node_id`
  
- `description` The detector is on the approach to this node.
  - `type` any
  - `constraints`:
    - `required` True
### `det_zone_lr`
  
- `description` Required. Distance from from the stop bar to detector in short_length units.
  - `type` number
  - `constraints`:
    - `required` True
### `det_zone_front`
  
- `description` Optional. Linear reference of front of detection zone in short_length units.
  - `type` number
### `det_zone_back`
  
- `description` Optional. Linear reference of back of detection zone in short_length units.
  - `type` number
### `det_type`
  
- `description` Optional. Type of detector.
  - `type` string
## `segment_tod`
  
- `description` An optional file that handles day-of-week and time-of-day restrictions on segments. It is used for part-time changes in segment capacity and number of lanes.
  - `path` segment_tod.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['segment_tod_id']
    - `foreignKeys`
      - [1]
        - `fields` ['segment_id']
        - `reference`
          - `resource` segment
          - `fields` ['segment_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
    - `fieldsMatch` subset
### `segment_tod_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `segment_id`
  
- `description` Foreign key to segment table.
  - `type` any
  - `constraints`:
    - `required` True
### `timeday_id`
  
- `description` Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
  - `type` any
### `time_day`
  
- `description` Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
  - `type` string
### `capacity`
  
- `description` Optional. Saturation capacity  pce / hr / lane
  - `type` number
  - `constraints`:
### `free_speed`
  
- `description` Optional. Free flow speed in units defined by config file
  - `type` number
  - `constraints`:
    - `maximum` 200
### `lanes`
  
- `description` Optional. Number of lanes in the direction of travel (must be consistent with link lanes + lanes added).
  - `type` integer
### `l_lanes_added`
  
- `description` Optional. # of lanes added on the left of the road link (negative indicates a lane drop).
  - `type` integer
### `r_lanes_added`
  
- `description` Optional. # of lanes added on the right of the road link (negative indicates a lane drop).
  - `type` integer
### `bike_facility`
  
- `description` Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template Table 1-A.  See https://data.transportation.gov/stories/s/National-Bicycle-Network/88zh-3rqb/
  - `type` string
### `ped_facility`
  
- `description` Optional. Type of pedestrian accommodation: unknown,none,shoulder,sidewalk,offstreet_path.
  - `type` string
### `parking`
  
- `description` Optional. Type of parking: unknown,none,shoulder,sidewalk,offstreet_path.
  - `type` string
### `toll`
  
- `description` Optional. Toll in currency units
  - `type` number
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
## `lane_tod`
  
- `description` An optional file that handles day-of-week and time-of-day restrictions on lanes that traverse entire links.
  - `path` lane_tod.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['lane_tod_id']
    - `foreignKeys`
      - [1]
        - `fields` ['lane_id']
        - `reference`
          - `resource` lane
          - `fields` ['lane_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
    - `fieldsMatch` subset
### `lane_tod_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `lane_id`
  
- `description` Required. Foreign key to `lane`
  - `type` any
  - `constraints`:
    - `required` True
### `timeday_id`
  
- `description` Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
  - `type` any
### `time_day`
  
- `description` Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
  - `type` string
### `lane_num`
  
- `description` Required. Lane number identified as offset to the right from the centerline. i.e. -1, 1, 2 (use left-to-rightnumbering).
  - `type` integer
  - `constraints`:
    - `required` True
    - `minimum` -10
    - `maximum` 10
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `r_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
  - `type` string
### `l_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default).  Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
  - `type` string
### `width`
  
- `description` Optional. Width of the lane, short_length units.
  - `type` number
  - `constraints`:
## `segment_lane_tod`
  
- `description` An optional file that handles day-of-week and time-of-day restrictions on lanes within segments of links.
  - `path` segment_lane_tod.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['segment_lane_tod_id']
    - `foreignKeys`
      - [1]
        - `fields` ['segment_lane_id']
        - `reference`
          - `resource` segment_lane
          - `fields` ['segment_lane_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
    - `fieldsMatch` subset
### `segment_lane_tod_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `segment_lane_id`
  
- `description` Required. Foreign key, segment_lane table
  - `type` any
  - `constraints`:
    - `required` True
### `timeday_id`
  
- `description` Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
  - `type` any
### `time_day`
  
- `description` Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
  - `type` string
### `lane_num`
  
- `description` Required. Lane number identified as offset to the right from the centerline. i.e. -1, 1, 2 (use left-to-rightnumbering).
  - `type` integer
  - `constraints`:
    - `required` True
    - `minimum` -10
    - `maximum` 10
### `allowed_uses`
  
- `description` Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
  - `type` string
### `r_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
  - `type` string
### `l_barrier`
  
- `description` Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
  - `type` string
### `width`
  
- `description` Optional. Width of the lane, short_length units.
  - `type` number
  - `constraints`:
## `zone`
  
- `description` Locates zones (travel analysis zones, parcels) on a map. Zones are represented as polygons in geographic information systems.
  - `path` zone.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['zone_id']
    - `foreignKeys`
      - [1]
        - `fields` ['super_zone']
        - `reference`
          - `resource` 
          - `fields` ['zone_id']
    - `fieldsMatch` subset
### `zone_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `name`
  
- `description` Optional.
  - `type` string
### `boundary`
  
- `description` Optional. The polygon geometry of the zone, as well-known text.
  - `type` any
### `super_zone`
  
- `description` Optional. If there is a hierarchy of zones (e.g., parcels and TAZs), indicates the zone of next higher level.
  - `type` string
## `config`
  
- `description` Configuration information for the dataset (units, coordinate systems, etc.).
  - `path` config.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `fieldsMatch` subset
    - `numRows` 1
### `dataset_name`
  
- `description` Name used to describe this GMNS network
  - `type` any
### `short_length`
  
- `description` Length unit used for lane/ROW widths and linear references for segments, locations, etc. along links
  - `type` any
### `long_length`
  
- `description` Length unit used for link lengths
  - `type` any
### `speed`
  
- `description` Units for speed. Usually long_length units per hour
  - `type` any
### `crs`
  
- `description` Coordinate system used for geometry data in this dataset. Preferably a string that can be accepted by pyproj (e.g., EPSG code or proj string)
  - `type` any
### `geometry_field_format`
  
- `description` The format used for geometry fields in the dataset. For example, `WKT` for files stored as plaintext
  - `type` any
### `currency`
  
- `description` Currency used in toll fields
  - `type` any
### `version_number`
  
- `description` The version of the GMNS spec to which this dataset conforms
  - `type` number
### `id_type`
  
- `description` The type of primary key IDs for interopability (node_id, zone_id, etc.). May be enforced by user, database schema, or downstream software. Must be either string or integer.
  - `type` string
  - `constraints`:
    - `enum` ['string', 'integer']
## `curb_seg`
  
- `description` Provides a separate segment object for curbside regulations, which may change at different locations than segment-level changes to the travel lanes.
  - `path` curb_seg.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['curb_seg_id']
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
### `curb_seg_id`
  
- `description` Primary key.
  - `type` any
  - `constraints`:
    - `required` True
### `link_id`
  
- `description` Required. Foreign key to road_links. The link that the segment is located on.
  - `type` any
  - `constraints`:
    - `required` True
### `ref_node_id`
  
- `description` Required. Foreign key to node where distance is 0.
  - `type` any
  - `constraints`:
    - `required` True
### `start_lr`
  
- `description` Required. Distance from `ref_node_id` in short_length units.
  - `type` number
  - `constraints`:
    - `required` True
### `end_lr`
  
- `description` Required. Distance from `ref_node_id`in short_length units.
  - `type` number
  - `constraints`:
    - `required` True
### `regulation`
  
- `description` Optional. Regulation on this curb segment.
  - `type` string
### `width`
  
- `description` Optional. Width (short_length units) of the curb segment.
  - `type` number
  - `constraints`: