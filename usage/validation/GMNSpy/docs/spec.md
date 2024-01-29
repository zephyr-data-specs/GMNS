# GMNS Schema
Schema for General Network Modeling Specification.

## Files in Specification

GMNS consists of a package of files as defined in the following table.

**The following table is automatically generated from `gmns.spec.json`**

| name                                            | description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | required   |
|:------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|
| [`link`](#link)                                 | A link is an edge in a network, defined by the nodes it travels from and to. It may have associated geometry information. Links have three types of attributes:<br>  - Those that define the physical location of the link (e.g., `shape` `information`, `length`, `width`)<br>  - Those that define the link's directionality: `from_node`, `to_node`<br>  - Those that define properties in the direction of travel: capacity, free flow speed, number of lanes, permitted uses, grade, facility type                                                                 | True       |
| [`node`](#node)                                 | A list of vertices that locate points on a map. Typically, they will represent intersections, but may also represent other points, such as a transition between divided and undivided highway. Nodes are the endpoints of a link (as opposed to the other type of vertex, location, which is used to represent points along a link)                                                                                                                                                                                                                                     | True       |
| [`geometry`](#geometry)                         | The geometry is an optional file that contains geometry information (shapepoints) for a line object. It is similar to Geometries in the SharedStreets reference system. The specification also allows for geometry information to be stored directly on the link table.                                                                                                                                                                                                                                                                                                 | False      |
| [`lane`](#lane)                                 | The lane file allocates portions of the physical right-of-way that might be used for travel. It might be a travel lane, bike lane, or a parking lane. Lanes only are included in directed links; undirected links are assumed to have no lane controls or directionality. If a lane is added, dropped, or changes properties along the link, those changes are recorded on the `segment_link` table. Lanes are numbered sequentially, starting at either the centerline (two-way street) or the left shoulder (one-way street or divided highway with two centerlines). | False      |
| [`link_tod`](#link_tod)                         | Handles day-of-week and time-of-day restrictions on links                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | False      |
| [`location`](#location)                         | A location is a vertex that is associated with a specific location along a link. Locations may be used to represent places where activities occur (e.g., driveways and bus stops). Its attributes are nearly the same as those for a node, except that the location includes an associated link and node, with location specified as distance along the link from the node.                                                                                                                                                                                             | True       |
| [`movement`](#movement)                         | Describes how inbound and outbound links connect at an intersection.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | False      |
| [`movement_tod`](#movement_tod)                 | Handles day-of-week and time-of-day restrictions on movements.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | False      |
| [`use_definition`](#use_definition)             | The Use_Definition file defines the characteristics of each vehicle type or non-travel purpose (e.g., a shoulder or parking lane). A two-way left turn lane (TWLTL) is also a use.                                                                                                                                                                                                                                                                                                                                                                                      | False      |
| [`use_group`](#use_group)                       | Defines groupings of uses, to reduce the size of the allowed_uses lists in the other tables.                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | False      |
| [`time_set_definitions`](#time_set_definitions) | The time_set_definitions file is an optional representation of time-of-day and day-of-week sets to enable time restrictions through `_tod` files.                                                                                                                                                                                                                                                                                                                                                                                                                       | False      |
| [`segment`](#segment)                           | A portion of a link defined by `link_id`,`ref_node_id`, `start_lr`, and `end_lr`. Values in the segment will override they value specified in the link table. When one segment is fully contained within another, its value prevails.                                                                                                                                                                                                                                                                                                                                   | False      |
| [`segment_lane`](#segment_lane)                 | Defines added and dropped lanes, and changes to lane parameters. If a lane is added, it has no parent. If it is changed or dropped, the parent_lane_id field keys to the associated lane on the lane table.                                                                                                                                                                                                                                                                                                                                                             | False      |
| [`signal_controller`](#signal_controller)       | The signal controller is associated with an intersection or a cluster of intersections.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | False      |
| [`signal_coordination`](#signal_coordination)   | Establishes coordination for several signal controllers, associated with a timing_plan.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | False      |
| [`signal_phase_mvmt`](#signal_phase_mvmt)       | Associates Movements and pedestrian Links (e.g., crosswalks) with signal phases. A signal phase may be associated with several movements. A Movement may also run on more than one phase.                                                                                                                                                                                                                                                                                                                                                                               | False      |
| [`signal_timing_plan`](#signal_timing_plan)     | For signalized nodes, establishes timing plans.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | False      |
| [`signal_timing_phase`](#signal_timing_phase)   | For signalized nodes, provides signal timing and establishes phases that may run concurrently.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | False      |
| [`signal_detector`](#signal_detector)           | A signal detector is associated with a controller, a phase and a group of lanes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | False      |
| [`segment_tod`](#segment_tod)                   | An optional file that handles day-of-week and time-of-day restrictions on segments. It is used for part-time changes in segment capacity and number of lanes.                                                                                                                                                                                                                                                                                                                                                                                                           | False      |
| [`lane_tod`](#lane_tod)                         | An optional file that handles day-of-week and time-of-day restrictions on lanes that traverse entire links.                                                                                                                                                                                                                                                                                                                                                                                                                                                             | False      |
| [`segment_lane_tod`](#segment_lane_tod)         | An optional file that handles day-of-week and time-of-day restrictions on lanes within segments of links.                                                                                                                                                                                                                                                                                                                                                                                                                                                               | False      |
| [`zone`](#zone)                                 | Locates zones (travel analysis zones, parcels) on a map. Zones are represented as polygons in geographic information systems.                                                                                                                                                                                                                                                                                                                                                                                                                                           | False      |

File components for GMNS are specified in `gmns.spec.json` in a format compatible with the
[frictionless data](https://specs.frictionlessdata.io/tabular-data-package/) data package standard.

Example `gmns.spec.json`:
```JSON
{
  "profile": "gmns-data-package",
  "profile_version":0.0,
  "name": "my-dataset",
  "resources": [
   {
     "name":"link",
     "path": "link.csv",
     "schema": "link.schema.json",
     "required": true
   },
   {
     "name":"node",
     "path": "node.csv",
     "schema": "node.schema.json",
     "required": true
   }
 ]
}
```

## Data Table Schemas
Data table schemas are specified in JSON and are compatible with the
[frictionless data](https://specs.frictionlessdata.io/table-schema/) table
schema standards.

Example:

```JSON
{
    "primaryKey": "segment_id",
    "missingValues": ["NaN",""],
    "fields": [
        {
            "name": "segment_id",
            "type": "any",
            "description": "Primary key.",
            "constraints": {
              "required": true,
              "unique": true
              }
        },
        {
            "name": "link_id",
            "type": "any",
            "description": "Required. Foreign key to link table. The link that the segment is located on.",
            "foreign_key": "link.link_id",
            "constraints": {
              "required": true
              }
        },
        {
            "name": "ref_node_id",
            "type": "any",
            "description": "Required. Foreign key to node.",
            "foreign_key": "node.node_id",
            "constraints": {
              "required": true
              }
        },
        {
            "name": "start_lr",
            "type": "number",
            "description": "Required. Distance from ref_node_id.",
            "constraints": {
              "required": true,
              "minimum": 0
              }
        },
        {
            "name": "end_lr",
            "type": "number",
            "description": "Required. Distance from ref_node_id.",
            "constraints": {
              "required": true,
              "minimum": 0
              }
          }
    ]
}

```


## geometry


|name|required|type|foreign_key|description|
|---|---|---|---|---|
|geometry_id|True|any|-|Primary key - could be SharedStreets Geometry ID|
|geometry|-|any|-|Optional. Link geometry, specific format could be WKT, GeoJSON, etc.|


## lane


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|---|
|lane_id|True|any|-|Primary key|-|-|-|
|link_id|True|any|Table: `link`, Variable: `link_id`|Required. Foreign key to link table.|-|-|-|
|lane_num|True|integer|-|Required. e.g., -1, 1, 2 (use left-to-right numbering).|-|10|-10|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|
|r_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.|Allowed Values: `none,regulatory,physical`|-|-|
|l_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.|Allowed Values: `none,regulatory,physical`|-|-|
|width|-|number|-|Optional. Width of the lane, feet.|-|-|0|


## lane_tod


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|---|
|lane_tod_id|True|any|-|Primary key.|-|-|-|
|lane_id|True|any|Table: `lane`, Variable: `lane_id`|Required. Foreign key to `lane`|-|-|-|
|timeday_id|-|any|Table: `time_set_definitions`, Variable: `timeday_id`|Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.|-|-|-|
|time_day|-|any|-|Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.|-|-|-|
|lane_num|True|integer|-|Required. Lane number identified as offset to the right from the centerline. i.e. -1, 1, 2 (use left-to-rightnumbering).|-|10|-10|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|
|r_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.|Allowed Values: `none,regulatory,physical`|-|-|
|l_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default).  Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.|Allowed Values: `none,regulatory,physical`|-|-|
|width|-|number|-|Optional. Width of the lane, feet.|-|-|0|


## link


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|warning maximum|warning minimum|warnings maximum|warnings minimum|
|---|---|---|---|---|---|---|---|---|---|---|---|
|link_id|True|any|-|Primary key - could be SharedStreets Reference ID|-|-|-|-|-|-|-|
|parent_link_id|-|any|Variable: `link_id`|Optional. The parent of this link. For example,for a sidewalk, this is the adjacent road.|-|-|-|-|-|-|-|
|name|-|string|-|Optional. Street or Path Name|-|-|-|-|-|-|-|
|from_node_id|True|any|Table: `node`, Variable: `node_id`|-|-|-|-|-|-|-|-|
|to_node_id|True|any|Table: `node`, Variable: `node_id`|-|-|-|-|-|-|-|-|
|directed|-|boolean|-|Required. Whether the link is directed (travel only occurs from the from_node to the to_node) or undirected.|-|-|-|-|-|-|-|
|geometry_id|-|any|Table: `geometry`, Variable: `geometry_id`|Optional. Foreign key (Link_Geometry table).|-|-|-|-|-|-|-|
|geometry|-|any|-|Optional. Link geometry, specific format could be WKT, GeoJSON, etc.|-|-|-|-|-|-|-|
|dir_flag|-|integer|-|Optional. <br>1  shapepoints go from from_node to to_node;<br>-1 shapepoints go in the reverse direction;<br>0  link is undirected or no geometry information is provided.|Allowed Values: `-1,0,1`|-|-|-|-|-|-|
|length|-|number|-|Optional. Length of the link in miles|-|-|0|-|-|-|-|
|grade|-|number|-|% grade, negative is downhill|-|100|-100|-|-|25|-25|
|facility_type|-|string|-|Facility type (e.g., freeway, arterial, etc.)|-|-|-|-|-|-|-|
|capacity|-|integer|-|Optional. Capacity (veh / hr / lane)|-|-|0|-|-|-|-|
|free_speed|-|integer|-|Optional. Free flow speed mph|-|100|0|-|-|75|1|
|lanes|-|integer|-|Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes.|-|-|0|-|-|-|-|
|bike_facility|-|string|-|Optional. Type of bicycle accommodation: unknown, none, wcl, sharrow, bikelane, cycletrack, offstreet path|Allowed Values: `unknown,none,wcl,sharrow,bikelane,cycletrack,offstreet path`|-|-|-|-|-|-|
|ped_facility|-|string|-|Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path|Allowed Values: `unknown,none,shoulder,sidewalk,offstreet path`|-|-|-|-|-|-|
|parking|-|string|-|Optional. Type of parking: unknown, none, parallel, angle, other|Allowed Values: `unknown,none,parallel,angle,other`|-|-|-|-|-|-|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|-|-|-|-|
|toll|-|integer|-|Optional.  Toll on the link, in cents.|-|-|-|10000|0|-|-|
|jurisdiction|-|string|-|Optional.  Owner/operator of the link.|-|-|-|-|-|-|-|
|row_width|-|number|-|Optional. Width (feet) of the entire right-of-way (both directions).|-|-|0|-|-|-|10|


## link_tod


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|warning maximum|warning minimum|warnings maximum|warnings minimum|
|---|---|---|---|---|---|---|---|---|---|---|---|
|link_tod_id|True|any|-|Primary key|-|-|-|-|-|-|-|
|link_id|True|any|Table: `link`, Variable: `link_id`|Required. Foreign key, link table|-|-|-|-|-|-|-|
|timeday_id|-|any|Table: `time_set_definitions`, Variable: `timeday_id`|Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.|-|-|-|-|-|-|-|
|time_day|-|any|-|Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.|-|-|-|-|-|-|-|
|capacity|-|integer|-|Optional. Capacity (veh / hr / lane)|-|-|0|-|-|-|-|
|free_speed|-|integer|-|Optional. Free flow speed mph|-|100|0|-|-|75|1|
|lanes|-|integer|-|Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes.|-|-|0|-|-|-|-|
|bike_facility|-|string|-|Optional. Type of bicycle accommodation: unknown, none, WCL, sharrow, bikelane, cycletrack, offstreet path|Allowed Values: `unknown,none,wcl,sharrow,bikelane,cycletrack,offstreet path`|-|-|-|-|-|-|
|ped_facility|-|string|-|Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path|Allowed Values: `unknown,none,shoulder,sidewalk,offstreet path`|-|-|-|-|-|-|
|parking|-|string|-|Optional. Type of parking: unknown, none, parallel, angle, other|Allowed Values: `unknown,none,parallel,angle,other`|-|-|-|-|-|-|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|-|-|-|-|
|toll|-|integer|-|toll in cents.|-|-|-|10000|0|-|-|


## location


|name|required|type|foreign_key|description|constraints minimum|
|---|---|---|---|---|---|
|loc_id|True|any|-|Primary key. Location ID.|-|
|link_id|True|any|Table: `link`, Variable: `link_id`|Required. Road Link ID. Foreign Key from Road_Link.|-|
|ref_node_id|True|any|Table: `node`, Variable: `node_id`|Required. The From node of the link. Foreign Key from Node.|-|
|lr|True|number|-|Required. Linear Reference of the location, measured as distance along the link from the reference node.  If link_geometry exists, it is used. Otherwise, link geometry is assumed to be a crow-fly distance from A node to B node.|0|
|x_coord|-|number|-|Optional. Either provided, or derived from Link, Ref_Node and LR.|-|
|y_coord|-|number|-|Optional. Either provided, or derived from Link, Ref_Node and LR.|-|
|z_coord|-|number|-|Optional. Altitude.|-|
|loc_type|-|string|-|Optional. What it represents (driveway, bus stop, etc.) OpenStreetMap map feature names are recommended.|-|
|zone_id|-|any|-|Optional. Foreign Key, Associated zone|-|
|gtfs_stop_id|-|string|-|Optional. Foreign Key to GTFS data. For bus stops and transit station entrances, provides a link to the General Transit Feed Specification.|-|


## movement


|name|required|type|foreign_key|description|constraints enum|
|---|---|---|---|---|---|
|mvmt_id|True|any|-|Primary key.|-|
|node_id|True|any|Table: `node`, Variable: `node_id`|The node representing the junction.|-|
|name|-|any|-|Optional.|-|
|ib_link_id|True|any|Table: `link`, Variable: `link_id`|Inbound link id.|-|
|start_ib_lane|-|integer|-|Innermost lane number the movement applies to at the inbound end.|-|
|end_ib_lane|-|integer|-|Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.|-|
|ob_link_id|True|any|Table: `link`, Variable: `link_id`|Outbound link id.|-|
|start_ob_lane|-|integer|-|Innermost lane number the movement applies to at the outbound end.|-|
|end_ob_lane|-|integer|-|Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.|-|
|type|True|string|-|Optional. Describes the type of movement (left, right, thru, etc.).|Allowed Values: `left,right,uturn,thru,merge`|
|penalty|-|any|-|Turn penalty (seconds)|-|
|capacity|-|any|-|Capacity in vehicles per hour.|-|
|ctrl_type|-|any|-|Optional. .|Allowed Values: `no_control,yield,stop,stop_2_way,stop_4_way,signal_with_RTOR,signal`|


## movement_tod


|name|required|type|foreign_key|description|constraints enum|
|---|---|---|---|---|---|
|mvmt_tod_id|True|any|-|Primary key.|-|
|mvmt_id|True|any|Table: `movement`, Variable: `mvmt_id`|The referenced movement.|-|
|time_day|-|string|-|Time of day in XXXXXXXX_HHMM_HHMM format, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.|-|
|timeday_id|-|string|Table: `timeday`, Variable: `timeday_id`|Time of day set. Used if times-of-day are defined on the time_set_definitions table|-|
|ib_link_id|True|any|Table: `link`, Variable: `link_id`|Inbound link id.|-|
|start_ib_lane|-|integer|-|Innermost lane number the movement applies to at the inbound end.|-|
|end_ib_lane|-|integer|-|Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.|-|
|ob_link_id|True|any|Table: `link`, Variable: `link_id`|Outbound link id.|-|
|start_ob_lane|-|integer|-|Innermost lane number the movement applies to at the outbound end.|-|
|end_ob_lane|-|integer|-|Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.|-|
|type|True|string|-|Optional. Describes the type of movement (left, right, thru, etc.).|Allowed Values: `left,right,uturn,thru,merge`|
|penalty|-|any|-|Turn penalty (seconds)|-|
|capacity|-|any|-|Capacity in vehicles per hour.|-|
|ctrl_type|-|any|-|Optional. .|Allowed Values: `no_control,yield,stop,stop_2_way,stop_4_way,signal_with_RTOR,signal`|


## node


|name|required|type|foreign_key|description|constraints enum|
|---|---|---|---|---|---|
|node_id|True|any|-|Primary key|-|
|name|-|string|-||-|
|x_coord|True|number|-|Coordinate system specified in config file (longitude, UTM-easting etc.)|-|
|y_coord|True|number|-|Coordinate system specified in config file (latitude, UTM-northing etc.)|-|
|z_coord|True|number|-|Optional. Altitude.|-|
|node_type|-|string|-|Optional. What it represents (intersection, transit station, park & ride).|-|
|ctrl_type|-|string|-|Optional. Intersection control type - one of ControlType_Set.|Allowed Values: `none,yield,stop,4_stop,signal`|
|zone_id|-|any|Table: `zone`, Variable: `zone_id`|Optional. Could be a Transportation Analysis Zone (TAZ) or city, or census tract, or census block.|-|
|parent_node_id|-|any|Variable: `node_id`|Optional. Associated node. For example, if this node is a sidewalk, a parent_nodek_id could represent the intersection  it is associated with.|-|


## segment


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|warnings maximum|warnings minimum|
|---|---|---|---|---|---|---|---|---|---|
|segment_id|True|any|-|Primary key.|-|-|-|-|-|
|link_id|True|any|Table: `link`, Variable: `link_id`|Required. Foreign key to road_links. The link that the segment is located on.|-|-|-|-|-|
|ref_node_id|True|any|Table: `node`, Variable: `node_id`|Required. Foreign key to node where distance is 0.|-|-|-|-|-|
|start_lr|True|number|-|Required. Distance from `ref_node_id`.|-|-|0|-|-|
|end_lr|True|number|-|Required. Distance from `ref_node_id`.|-|-|0|-|-|
|grade|-|number|-|% grade, negative is downhill|-|100|-100|25|-25|
|capacity|-|integer|-|Optional. Capacity (veh/hr/ln)|-|-|0|-|-|
|free_speed|-|integer|-|Optional. Free flow speed (mph)|-|100|0|75|1|
|lanes|-|integer|-|Optional. Number of lanes in the direction of travel (must be consistent with link lanes + lanes added).|-|-|-|-|-|
|l_lanes_added|-|integer|-|Optional. # of lanes added on the left of the road link (negative indicates a lane drop).|-|-|-|-|-|
|l_lanes_added|-|integer|-|Optional. # of lanes added on the left of the road link (negative indicates a lane drop).|-|-|-|-|-|
|r_lanes_added|-|integer|-|Optional. # of lanes added on the right of the road link (negative indicates a lane drop).|-|-|-|-|-|
|bike_facility|-|string|-|Optional. Type of bicycle accommodation: unknown, none,wcl, bikelane,cycletrack,wide_shoulder, offstreet_path.|Allowed Values: `unknown,none,wcl,bikelane,cycletrack,wide_shoulder,offstreet_path`|-|-|-|-|
|ped_facility|-|string|-|Optional. Type of pedestrian accommodation:unknown,none,shoulder,sidewalk,offstreet_path.|Allowed Values: `unknown,none,shoulder,sidewalk,offstreet_path`|-|-|-|-|
|parking|-|string|-|Optional. Type of parking: unknown,none,shoulder,sidewalk,offstreet_path.|Allowed Values: `unknown,none,shoulder,sidewalk,offstreet_path`|-|-|-|-|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|-|-|
|toll|-|integer|-|Optional.  Toll on the segment, in cents.|-|-|-|-|-|
|jurisdiction|-|string|-|Optional. Optional.  Owner/operator of the segment.|-|-|-|-|-|
|row_width|-|number|-|Optional. Width (feet) of the entire right-of-way (both directions).|-|-|0|-|10|


## segment_lane


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|---|
|segment_lane_id|True|any|-|Primary key.|-|-|-|
|segment_id|True|any|Table: `segment`, Variable: `segment_id`|Required. Foreign key to the associated segment.|-|-|-|
|lane_num|True|integer|-|Required. -1, 1, 2 (use left-to-right numbering). 0 signifies a lane that is dropped on the segment.|-|10|-10|
|parent_lane_id|-|any|-|Optional. If a lane drops or changes characteristics on the segment, the lane_id for that lane.|-|-|-|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|
|r_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right (default is none)|Allowed Values: `none,regulatory,physical`|-|-|
|l_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the left (default is none)|Allowed Values: `none,regulatory,physical`|-|-|
|width|-|number|-|Optional. Width of the lane (feet)|-|-|0|


## segment_lane_tod


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|---|
|segment_lane_tod_id|True|any|-|Primary key.|-|-|-|
|segment_lane_id|True|any|Table: `segment_lane`, Variable: `segment_lane_id`|Required. Foreign key, segment_lane table|-|-|-|
|timeday_id|-|any|Table: `time_set_definitions`, Variable: `timeday_id`|Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.|-|-|-|
|time_day|-|any|-|Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.|-|-|-|
|lane_num|True|integer|-|Required. Lane number identified as offset to the right from the centerline. i.e. -1, 1, 2 (use left-to-rightnumbering).|-|10|-10|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|
|r_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.|Allowed Values: `none,regulatory,physical`|-|-|
|l_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.|Allowed Values: `none,regulatory,physical`|-|-|
|width|-|number|-|Optional. Width of the lane, feet.|-|-|0|


## segment_tod


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|warnings maximum|warnings minimum|
|---|---|---|---|---|---|---|---|---|---|
|segment_tod_id|True|any|-|Primary key.|-|-|-|-|-|
|segment_id|True|any|Table: `segment`, Variable: `segment_id`|Foreign key to segment table.|-|-|-|-|-|
|timeday_id|-|any|Table: `time_set_definitions`, Variable: `timeday_id`|Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.|-|-|-|-|-|
|time_day|-|any|-|Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.|-|-|-|-|-|
|capacity|-|integer|-|Optional. Capacity (veh/hr/ln)|-|-|0|-|-|
|free_speed|-|integer|-|Optional. Free flow speed (mph)|-|100|0|75|1|
|lanes|-|integer|-|Optional. Number of lanes in the direction of travel (must be consistent with link lanes + lanes added).|-|-|-|-|-|
|l_lanes_added|-|integer|-|Optional. # of lanes added on the left of the road link (negative indicates a lane drop).|-|-|-|-|-|
|r_lanes_added|-|integer|-|Optional. # of lanes added on the right of the road link (negative indicates a lane drop).|-|-|-|-|-|
|bike_facility|-|string|-|Optional. Type of bicycle accommodation: unknown, none,wcl, bikelane,cycletrack,wide_shoulder, offstreet_path.|Allowed Values: `unknown,none,wcl,bikelane,cycletrack,wide_shoulder,offstreet_path`|-|-|-|-|
|ped_facility|-|string|-|Optional. Type of pedestrian accommodation: unknown,none,shoulder,sidewalk,offstreet_path.|Allowed Values: `unknown,none,shoulder,sidewalk,offstreet_path`|-|-|-|-|
|parking|-|string|-|Optional. Type of parking: unknown,none,shoulder,sidewalk,offstreet_path.|Allowed Values: `unknown,none,shoulder,sidewalk,offstreet_path`|-|-|-|-|
|toll|-|integer|-|Optional. Toll in cents|-|-|-|-|-|
|allowed_uses|-|string|-|Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.|-|-|-|-|-|


## signal_controller


|name|required|type|foreign_key|description|
|---|---|---|---|---|
|controller_id|True|any|-|Primary key.|


## signal_coordination


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|---|
|coordination_id|True|any|-|Primary key.|-|-|-|
|timing_plan_id|True|any|Table: `signal_timing_plan`, Variable: `timing_plan_id`|Required. Foreign key (Signal_timing_plan table).|-|-|-|
|controller_id|True|any|Table: `signal_controller`, Variable: `controller_id`|Required. Foreign key (signal_controller table).|-|-|-|
|coord_contr_id|-|any|Table: `signal_controller`, Variable: `controller_id`|Optional. For coordinated signals, the master signal controller for coordination.|-|-|-|
|coord_phase|-|integer|-|Optional. For coordinated signals, the phase at which coordination starts (time 0).|-|32|0|
|coord_ref_to|-|string|-|Optional. For coordinated signals, the part of the phase where coordination starts: begin_of_green, begin_of_yellow, begin_of_red.|Allowed Values: `begin_of_green,begin_of_yellow,begin_of_red`|-|-|
|offset|-|integer|-|Optional. Offset in seconds.|-|-|0|


## signal_detector


|name|required|type|foreign_key|description|
|---|---|---|---|---|
|detector_id|True|any|-|Primary key.|
|controller_id|True|any|Table: `signal_controller`, Variable: `controller_id`|Required. Foreign key to signal_controller table.|
|signal_phase_num|True|integer|-|Required. Number of the associated phase.|
|link_id|True|any|Table: `link`, Variable: `link_id`|Foreign key. The link covered by the detector.|
|start_lane|True|integer|-|Left-most lane covered by the detector.|
|end_lane|-|integer|-|Right-most lane covered by the detector (blank if only one lane).|
|ref_node_id|True|any|Table: `node`, Variable: `node_id`|The detector is on the approach to this node.|
|det_zone_lr|True|number|-|Required. Distance from from the stop bar to detector.|
|det_zone_front|-|number|-|Optional. Linear reference of front of detection zone.|
|det_zone_back|-|number|-|Optional. Linear reference of back of detection zone.|
|det_type|-|string|-|Optional. Type of detector.|


## signal_phase_mvmt


|name|required|type|foreign_key|description|constraints enum|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|---|
|signal_phase_mvmt_id|True|any|-|Primary key.|-|-|-|
|controller_id|True|any|Table: `signal_controller`, Variable: `controller_id`|Associated controller.|-|-|-|
|signal_phase_num|True|integer|-|Each phase has one or more Movements associated with it.|-|32|0|
|mvmt_id|-|any|Table: `movement`, Variable: `mvmt_id`|Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required.|-|-|-|
|link_id|-|any|Table: `link`, Variable: `link_id`|Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required.|-|-|-|
|protection|-|any|-|Optional. Indicates whether the phase is protected, permitted, or right turn on red.|Allowed Values: `protected,permitted,rtor`|-|-|


## signal_timing_phase


|name|required|type|foreign_key|description|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|
|timing_phase_id|True|any|-|Primary key.|-|-|
|timing_plan_id|-|any|Table: `signal_timing_plan`, Variable: `timing_plan_id`|Foreign key; connects to a timing_plan associated with a controller.|-|-|
|signal_phase_num|True|integer|-|Signal phase number.|-|0|
|min_green|-|integer|-|The minimum green time in seconds for an actuated signal. Green time in seconds for a fixed time signal.|-|0|
|max_green|-|integer|-|Optional.The maximum green time in seconds for an actuated signal; the default is minimum green plus one extension|-|0|
|extension|-|integer|-|Optional. The number of seconds the green time is extended each time vehicles are detected.|120|0|
|clearance|-|integer|-|Yellow interval plus all red interval|120|0|
|walk_time|-|integer|-|If a pedestrian phase exists, the walk time in seconds|120|0|
|ped_clearance|-|integer|-|If a pedestrian phase exists, the flashing don't walk time.|120|0|
|ring|True|integer|-|Required. Set of phases that conflict with each other. |12|0|
|barrier|True|integer|-|Required. Set of phases that can operate other.|12|0|
|position|True|integer|-|Required. Position.|-|-|


## signal_timing_plan


|name|required|type|foreign_key|description|constraints maximum|constraints minimum|
|---|---|---|---|---|---|---|
|timing_plan_id|True|any|-|Primary key.|-|-|
|controller_id|True|any|Table: `signal_controller`, Variable: `controller_id`|Required. Foreign key (signal_controller table).|-|-|
|timeday_id|-|any|Table: `time_set_definitions`, Variable: `timeday_id`|Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.|-|-|
|time_day|-|any|-|Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.|-|-|
|cycle_length|-|integer|-|Cycle length in seconds.|600|0|


## time_set_definitions


|name|required|type|foreign_key|description|
|---|---|---|---|---|
|timeday_id|True|any|-|Primary key.Primary key, similar to `service_id` in GTFS. Unique name of the time of day. Preferable legible rather than a number.|
|monday|True|boolean|-|Required. Whether Mondays are included.|
|tuesday|True|boolean|-|Required. Whether Tuesdays are included.|
|wednesday|True|boolean|-|Required. Whether Wednesdays are included.|
|thursday|True|boolean|-|Required. Whether Thursdays are included.|
|Friday|True|boolean|-|Required. Whether Fridays are included.|
|saturday|True|boolean|-|Required. Whether Saturdays are included.|
|sunday|True|boolean|-|Required. Whether Sundays are included.|
|holiday|True|boolean|-|Required. Whether holidays are included.|
|start_time|True|time|-|Required. Start time in HH:MM format.|
|end_time|True|time|-|Required. End  time in HH:MM format.|


## use_definition


|name|required|type|foreign_key|description|constraints minimum|
|---|---|---|---|---|---|
|use|True|string|-|Primary key|-|
|persons_per_vehicle|True|number|-|Required.|0|
|pce|True|number|-|Required. Passenger car equivalent.|0|
|special_conditions|-|string|-|Optional.|-|
|description|-|string|-|Optional |-|


## use_group


|name|required|type|foreign_key|description|
|---|---|---|---|---|
|use_group|True|string|-|Primary key.|
|uses|True|string|-|Comma-separated list of uses.|
|description|-|string|-|Optional.|


## zone


|name|required|type|foreign_key|description|
|---|---|---|---|---|
|zone_id|True|any|-|Primary key.|
|name|-|any|-|Optional.|
|boundary|-|any|-|Optional. The polygon geometry of the zone in WKT or Polygon.|
|super_zone|-|string|Variable: `zone_id`|Optional. If there is a hierarchy of zones (e.g., parcels and TAZs), indicates the zone of next higher level.|
