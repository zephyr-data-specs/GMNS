#	Node	
The node file is a list of vertices that locate points on a map. Typically, they will represent intersections, but may also represent other points, such as a transition between divided and undivided highway.  Nodes are the endpoints of a link (as opposed to the other type of vertex, [location](Location.md), which is used to represent points along a link).

node data dictionary

Field | Type | Required? | Comment
---|---|---|---
node_id | Node_ID | Required | Unique key
name | TEXT | Optional | 
x_coord | DOUBLE | Required | Coordinate system specified in config file (longitude, UTM-easting etc.)
y_coord | DOUBLE | Required | Coordinate system specified in config file (longitude, UTM-easting etc.)
z_coord | DOUBLE | Optional | Altitude
node_type | TEXT | Optional | What it represents (intersection, transit station, park & ride)
ctrl_type | ControlType_Set | Optional | Intersection control type, from ControlType_Set: no_control, yield, stop_2_way, stop_4_way, signal
zone_id | Zone_ID | Optional | Could be a Transportation Analysis Zone (TAZ) or city, or census tract, or census block
parent_node_id | Node_ID | Optional | The parent of this node; for example, a pedestrian node at one corner of an intersection's parent is the intersection itself.

Ad hoc fields (e.g., area, subarea, associated GTFS stop) may also be added. 

