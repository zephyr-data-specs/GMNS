## `geometry`
  - `description` The geometry is an optional file that contains geometry information (shapepoints) for a line object. It is similar to Geometries in the SharedStreets reference system. The specification also allows for geometry information to be stored directly on the link table.
  - `path` geometry.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['geometry_id']
    - `fieldsMatch` subset
  
| name        | type   | description                                                                                                                                                                               | constraints        |
|:------------|:-------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------|
| geometry_id | any    | Primary key - could be SharedStreets Geometry ID                                                                                                                                          | {'required': True} |
| geometry    | any    | Link geometry, in well-known text (WKT) format.  Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json. |                    |