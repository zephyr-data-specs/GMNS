The geometry is an optional file that contains geometry information (shapepoints) for a line object.  It is similar to Geometries in the SharedStreets reference system.

| Field                                               | Type                  | Required?  | Comment                                                                                                                                              |
| --------------------------------------------------- | --------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| geometry\_id | Geometry_ID            | Required | Primary key, could be SharedStreets Geometry ID                                                                                                    |
| geometry                                            | Geometry              | Optional   | Link geometry, specific format could be WKT, GeoJSON, PostGIS geometry datatype                                                                      |
