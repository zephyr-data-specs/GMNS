# General Modeling Network Specification (GMNS) 

Volpe/FHWA partnership with [Zephyr Foundation](https://zephyrtransport.org).

The General Modeling Network Specification (GMNS) defines a common human and machine readable format for sharing routable road network files.  It is designed to be used in multi-modal static and dynamic transportation planning and operations models.  

How do I use GMNS?
1.  Read the [__specification reference__](../../wiki) to learn about the GMNS format.
2.	Look at our [__small examples__](Small_Network_Examples), including a freeway interchange, a portion of a multimodal city network, and a small city.
3.	Build and test your own small network. We have basic tools in Python and R for [__conversion__](Conversion_Tools) and [__validation__](Validation_Tools).  

## GMNS Overview
Version 0.80 includes the following features for use in static models:
-	Configuration information and use definitions.
-	Node and road_link files, to establish a routable directed network.
-	A link_geometry file containing the geometry and physical characteristics of links.

For dynamic models, this version includes the following optional additional features:
-	An offroad_link file, for building undirected routable networks (like sidewalks)
-	A segment file, with information that overrides the characteristics of a portion of a road_link.  
-	A lane file that allocates portions of the right-of-way. Lanes include travel lanes used by motor vehicles. They may also optionally include bike lanes, parking lanes, and shoulders. 
-	A location file, that specifies points along a link (e.g., driveways or GTFS bus stops)
-	A link_TOD file, that allocates usage of links (or lanes) by time-of-day and day-of-week.  
-	Movement and Movement_TOD files that specifies how inbound and outbound lanes connect at an intersection, and time/day restrictions on those movements. 
-	Signal phase and timing files, for basic implementation of traffic signals.

Table 1 Use of the specification in macro, meso and micro models

Component of the data specification	| Macro Models	| Meso and Micro Models
--- | --- | --- 
Physical network elements on the map |	Nodes, link_geometry | Nodes, link_geometry
Connecting the elements	| Nodes and road_links	| Movements and lanes
Link capacity	| Link capacity	| Emergent property of lanes and the model used
Intersection capacity	| Not considered	| Emergent property of lanes, movements and traffic controls
Speed	| Link speed	| Link speed and movement delay
Pedestrian network	| Road_link pedestrian facility information	| Road_link pedestrian facility information or offroad_links
Traffic controls	| Node, Road_Link, Movement	| Movement and signal tables
Elements that vary by time of day| 	Not used	| Link_TOD, Movement_TOD


Members of the Zephyr Foundation project, General Travel Network Data Standard and Tools, and other interested stakeholders are invited to review and comment on the specification. In developing this specification, we consulted existing open-source specifications, including SharedStreets, OpenDrive, MATSim, Network EXplorer for Traffic Analysis (NEXTA) or DTALite, TRansportation ANalysis SIMulation System (TRANSIMS),  Aequilibrae , Highway Performance Monitoring System (HPMS), All Road Network of Linear Referenced Data (ARNOLD), the Florida Transportation Modeling Portal (FSUTMS), and the Synchro Universal Traffic Data Format (UTDF). 


