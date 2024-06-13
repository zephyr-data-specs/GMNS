## `schema`

| name        | type   | description                                                                                                                                                                               | constraints        |
|:------------|:-------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------|
| geometry_id | any    | Primary key - could be SharedStreets Geometry ID                                                                                                                                          | {'required': True} |
| geometry    | any    | Link geometry, in well-known text (WKT) format.  Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json. |                    |