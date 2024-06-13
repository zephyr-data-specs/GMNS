CREATE TABLE IF NOT EXISTS geometry (
    geometry_id VARCHAR(255) NOT NULL,  -- Primary key - could be SharedStreets Geometry ID
    geometry VARCHAR(255),  -- Link geometry, in well-known text (WKT) format.  Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json.
    PRIMARY KEY (geometry_id)
);