The geometry is an optional file that contains geometry information (shapepoints) for a line object.  It is similar to Geometries in the SharedStreets reference system.
The specification also allows for geometry information to be stored directly on the link table.

| Field                                               | Type                  | Required?  | Comment                                                                                                                                              |
| --------------------------------------------------- | --------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| geometry\_id | Geometry_ID            | Required | Primary key, could be SharedStreets Geometry ID                                                                                                    |
| geometry                                            | Geometry              | Optional   | Link geometry, in well-known text (WKT) format.  Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used.                                                                      |
