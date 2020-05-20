# General Modeling Network Specification (GMNS) 

Volpe/FHWA partnership with [Zephyr Foundation](https://zephyrtransport.org).

The General Modeling Network Specification (GMNS) defines a common human and machine readable format for sharing routable road network files.  It is designed to be used in multi-modal static and dynamic transportation planning and operations models.  

How do I use GMNS?
1.  Read the [__specification reference__](Specification) to learn about the GMNS format.
2.	Look at our [__small examples__](Small_Network_Examples), including a freeway interchange, a portion of a multimodal city network, and a small city.
3.	Build and test your own small network. We have basic tools in Python and R for [__conversion__](Conversion_Tools) and [__validation__](Validation_Tools).  

**Note**: Some of the examples, and all of the conversion and validation tools, have not yet been updated to reflect the latest changes to the specification. These are indicated by the following sign :warning: in their respective readme files.

## GMNS Overview
Version 0.85 includes the following features for use in static models:
-	Configuration information and use definitions.
-	Node and link files, to establish a routable network. 

For dynamic models, this version includes the following optional additional features:
-	A segment file, with information that overrides the characteristics of a portion of a link.  
-	A lane file that allocates portions of the right-of-way. Lanes include travel lanes used by motor vehicles. They may also optionally include bike lanes, parking lanes, and shoulders. 
-	A segment_lane file that specifies additional lanes, dropped lanes, or changes to lane properties on a segment of a link.
-	A movement file that specifies how inbound and outbound lanes connect at an intersection
-	Link, segment, lane and movement time-of-day (TOD) files, that allocates usage of network elements by time-of-day and day-of-week. 
-	Signal phase and timing files, for basic implementation of traffic signals.

Table 1 Use of the specification in macro, meso and micro models

Component of the data specification	| Macro Models	| Meso and Micro Models
--- | --- | --- 
Physical network elements on the map |	Nodes, links | Nodes, links
Connecting the elements	| Nodes and links	| Movements and lanes
Link capacity	| Link capacity	| Emergent property of lanes and the model used
Intersection capacity	| Not considered	| Emergent property of lanes, movements and traffic controls
Speed	| Link speed	| Link speed and movement delay
Pedestrian network	| ped_facility field on the link table	| ped_facility field on the link table, or separate lanes or links representing the pedestrian facilities
Traffic controls	| Node, link, movement	| Movement and signal tables
Elements that vary by time of day| 	Not used	| link_TOD, link_lane_TOD, segment_TOD, segment_lane_TOD, movement_TOD


Members of the Zephyr Foundation project, [General Travel Network Data Standard and Tools](https://zephyrtransport.org/projects/2-network-standard-and-tools/), and other interested stakeholders are invited to review and comment on the specification. In developing this specification, we consulted existing open-source specifications, including SharedStreets, OpenDrive, MATSim, Network EXplorer for Traffic Analysis (NEXTA) or DTALite, TRansportation ANalysis SIMulation System (TRANSIMS),  Aequilibrae , Highway Performance Monitoring System (HPMS), All Road Network of Linear Referenced Data (ARNOLD), the Florida Transportation Modeling Portal (FSUTMS), and the Synchro Universal Traffic Data Format (UTDF). 