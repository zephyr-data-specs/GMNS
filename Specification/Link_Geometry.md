#	link_geometry	
The link_geometry is a foundational object that contains the physical
characteristics of the links used in GMNS. A link object can
(optionally) reference this object to include physical information in
the network. Currently, GMNS uses road links (for places where vehicles
operate in lanes in a single direction) and offroad links (for
pedestrian facilities, which are undirected). A future version of GMNS
may expand to other types of links. Multiple network links can reference
the same Link_Geometry (for example, two directions on a road may share
the same line geometry). The Link_Geometry field is similar to the concept of a
[way](https://wiki.openstreetmap.org/wiki/Way) in OpenStreetMap.

link_geometry data dictionary

| Field                                               | Type                  | Required?  | Comment                                                                                                                                              |
| --------------------------------------------------- | --------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| link_geom\_id | Link\_Geometry_ID            | Required | Primary key, could be SharedStreets Geometry ID                                                                                                    |
| name                                              | TEXT                | Optional |                                                                                                                                                      |
| geometry                                            | Geometry              | Optional   | Link geometry, specific format could be WKT, GeoJSON, PostGIS geometry datatype                                                                      |
| length                                              | DOUBLE                | Optional   | The length of the link                                                                                                                               |
| row_width                                            | DOUBLE                | Optional   | Width of the entire right-of-way. May be useful for predicting what changes might be possible in future years.                                       |
| jurisdiction                                        | TEXT                  | Optional   | Owner/operator of the physical link                                                                                                                 |
| Other fields                                        | INTEGER, DOUBLE, TEXT | Optional   | Examples of other fields might include traffic message channel (TMC) identifier, traffic count sensor identifier and location, average daily traffic |