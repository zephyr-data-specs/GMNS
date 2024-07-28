# General Modeling Network Specification (GMNS) 

Volpe/FHWA partnership with [Zephyr Foundation](https://zephyrtransport.org).

The General Modeling Network Specification (GMNS) defines a common machine (and human) readable format for sharing routable road network files.  It is designed to be used in multi-modal static and dynamic transportation planning and operations models.  

How do I use GMNS?
1.  Read the [__specification reference__](spec) to learn about the GMNS format. GMNS is described in json files, and is implementation-agnostic.  A GMNS network might be stored as a series of delimited text files, as a relational database with several tables, or in some other way.   
2.	Look at our [__small examples__](examples), including a freeway interchange, a portion of a multimodal city network, and a small city.
3.	Build and test your own small network. We have basic tools in Python and R for [__conversion__](usage/conversion) and [__validation__](usage/validation).  

## GMNS Overview
Version 0.96 includes the following features for use in static models:
-	Configuration information and use definitions.
-	Node and link files, to establish a routable network. 

For dynamic models, this version includes the following optional additional features:
-	A segment file, with information that overrides the characteristics of a portion of a link.  
-	A lane file that allocates portions of the right-of-way. Lanes include travel lanes used by motor vehicles. They may also optionally include bike lanes, parking lanes, and shoulders. 
-	A segment_lane file that specifies additional lanes, dropped lanes, or changes to lane properties on a segment of a link.
-	A movement file that specifies how inbound and outbound lanes connect at an intersection
-	Link, segment, lane and movement time-of-day (TOD) files, that allocates usage of network elements by time-of-day and day-of-week. 
-	Signal phase and timing files, for basic implementation of traffic signals.

_Table: Use of the specification in macro, meso and micro models_

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


## General GMNS Concepts
### Time of Day
There are two parts to implementing a time of day change. First, the default behavior of a link, segment, or lane (how it operates the majority of the time) is recorded on the "main" link, segment, or lane tables. Then, [time-of-day](docs/spec/TOD.md) (TOD) tables can be used to modify how the component functions during certain time of day (and day of week) periods. 

The first part is necessary even for components that do not exist outside of a specific time of day. For example, a reversible lane requires two records on the lanes table: one associated with the link it normally moves with, and one with the link in the opposite direction. The allowed_uses field will be None for these non-peak times on the opposite-direction link, but the lane is still necessary so that the TOD attributes can be linked to it. You can find our examples of reversible lanes and other time of day changes [here](examples/TOD_Examples).
### Difference between Lane Field and Lanes Table
On links and segments, there is a field called `lanes`. The number of lanes in the lanes table associated with a link may not always match this value. This  field is maintained for compatibility with static models, where the Lanes table may not be used. Here, it is treated as the number of permanent lanes (not including turn pockets) open to motor vehicles. 
### Inheritance
Much of this specification works in terms of inheritance and parent/child relationships. For example, segments (child) inherit attributes from links (parent). To avoid repetitive data, GMNS assumes that attributes left blank on a child are the same as its parent. See the [inheritance relationship chart for more details](spec#inheritance-relationships).
### Pedestrian Facilities vs Allowed Uses vs Separate Links
Whether pedestrians are allowed on a link on the network can be represented in multiple ways. The `ped_facility` field in a link or segment describes the type (if any) of built facilities specifically for accommodating pedestrian travel. The `allowed_uses` field is more general and shows if it is possible for a pedestrian to walk along this link. For example, there could be a low-traffic road with no explicit pedestrian facility, but is part of the pedestrian network. For more detailed networks, GMNS also allows undirected links to be used to specifically represent pedestrian facilities, such as sidewalks. 
### Approach to Transit
We recommend incorporating GTFS for transit modeling needs. GTFS (General Transit Feed Specification) is a widely used and well-defined specification for transit. GMNS allows [locations](docs/spec/Location.md) that represent transit stops to link to GTFS stops with the `gtfs_stop_id` field and ad hoc fields can always be added to meet your needs. 

## FAQ
### What are the goals of GMNS?
The objective of General Modeling Network Specification (GMNS) is to provide a common human and machine readable format for sharing routable road network files. It is designed to be used in multi-resolution and multi-modal static and dynamic transportation planning and operations models. It will facilitate the sharing of tools and data sources by modelers.
For additional information on GMNS goals, history and requirements, please see the [wiki](https://github.com/zephyr-data-specs/GMNS/wiki).  
### What type of system can be represented in GMNS?
GMNS is made to be flexible, multimodal, and multiresolution. Many of the fields and tables are optional depending on how detailed of information you have for your system. At a high level, GMNS simply models a network of nodes and links. However you can put in as much detail as required by adding lanes, movements, geometry information, etc.  
### How do I represent geometry shapepoints?
There are two ways in GMNS to represent geometry shapepoints for links. Shapepoints can be recorded as well-known text (WKT) in the `geometry` field of the [link table](docs/spec/Link.md) or shapepoints can be placed in the separate [geometry table](docs/spec/Geometry.md) and keyed to the link table through the `geometry_id` field.
### How do I represent sidewalks?
In the [link table](docs/spec/Link.md) there is a field to indicate a pedestrian facility (`ped_facility`). You can also represent the pedestrian network (sidewalks, crosswalks and other paths) as its own network with its own links.  See the [Cambridge example](examples/Cambridge_Intersection).  
### How do I represent bicycle facilities?
In the [link table](docs/spec/Link.md) there is a field to indicate a bicycle facility (`bike_facility`). To represent a bicycle network in more detail, additional options include representing on-road bike lanes as explicit lanes in the [lane table](docs/spec/Lane.md) or representing other bicycle facilities (e.g., shared use paths, separated bike lanes, contra-flow bike lanes) as their own links.    
### How do I represent street furniture and curbside regulations?
Locations and segments can be used for purposes like these. The [location table](docs/spec/Location.md) is way to represent point information on a link and the [curb_seg table](docs/spec/Curb_seg.md) or [segment table](docs/spec/Segment.md) can represent information for a portion of a link. Both are defined by a linear reference along a link. Remember, the user may add ad hoc fields to any table in GMNS to represent any type of information that is important to their network.
### What counts as a lane for the lanes field on a link or segment table?
Only vehicle travel lanes traversing the entire link are counted in the `lanes` field in the [link table](docs/spec/Link.md). This may not be the same as the number of associated records in the [lanes table](docs/spec/Lane.md), which can represent lanes of any type, such as bike lanes, shoulders, or reversible lanes (more on reverisble lanes in [our time of day change examples](examples/TOD_Examples).
### What is needed to define a time-of-day (TOD) change?
A TOD file can’t exist without the link, lane, segment, etc. having been defined on the base table first. See [time of day, above](#time-of-day). 
### How should I represent transit data in GMNS?
You can link a GTFS stop id in the location table. We recommend using GTFS as your primary means of representing transit networks as it is well-established and widely used. For more discussion on the representation of stops in GMNS see [Issue #12](https://github.com/zephyr-data-specs/GMNS/issues/12).
### Are there standardized values for fields such as node_type and allowed_uses?
There are several fields which require a type input, such as `node_type`, where GMNS does not provide a standardized list of values. However, we do recommend using the Open Street Maps (OSM) standards as a guide, particularly [highway features](https://wiki.openstreetmap.org/wiki/Map_Features#Other_highway_features) and [amenities (transportation)](https://wiki.openstreetmap.org/wiki/Key:amenity#Transportation). For more discussion on this see [Issue #10](https://github.com/zephyr-data-specs/GMNS/issues/10). 
