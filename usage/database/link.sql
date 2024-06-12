CREATE TABLE IF NOT EXISTS link (
    link_id VARCHAR(255) NOT NULL,  -- Primary key - could be SharedStreets Reference ID
    parent_link_id VARCHAR(255),  -- Optional. The parent of this link. For example,for a sidewalk, this is the adjacent road.
    name VARCHAR(255),  -- Optional. Street or Path Name
    from_node_id VARCHAR(255) NOT NULL,  -- Required: origin node
    to_node_id VARCHAR(255) NOT NULL,  -- Required: destination node
    directed VARCHAR(255),  -- Required. Whether the link is directed (travel only occurs from the from_node to the to_node) or undirected.
    geometry_id VARCHAR(255),  -- Optional. Foreign key (Link_Geometry table).
    geometry VARCHAR(255),  -- Optional. Link geometry, in well-known text (WKT) format. Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json
    dir_flag VARCHAR(255),  -- Optional. <br>1  shapepoints go from from_node to to_node;<br>-1 shapepoints go in the reverse direction;<br>0  link is undirected or no geometry information is provided.
    length FLOAT,  -- Optional. Length of the link in long_length units
    grade FLOAT,  -- % grade, negative is downhill
    facility_type VARCHAR(255),  -- Facility type (e.g., freeway, arterial, etc.)
    capacity FLOAT,  -- Optional. Capacity (veh / hr / lane)
    free_speed FLOAT,  -- Optional. Free flow speed, units defined by config file
    lanes VARCHAR(255),  -- Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes.
    bike_facility VARCHAR(255),  -- Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A at https://nmtdev.ornl.gov/assets/templates/NBN_DataTemplates_final.pdf)
    ped_facility VARCHAR(255),  -- Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path
    parking VARCHAR(255),  -- Optional. Type of parking: unknown, none, parallel, angle, other
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    toll FLOAT,  -- Optional.  Toll on the link, in currency units.
    jurisdiction VARCHAR(255),  -- Optional.  Owner/operator of the link.
    row_width FLOAT,  -- Optional. Width (short_length units) of the entire right-of-way (both directions).
    PRIMARY KEY (link_id),
    FOREIGN KEY (parent_link_id) REFERENCES (link_id),
    FOREIGN KEY (from_node_id) REFERENCES node(node_id),
    FOREIGN KEY (to_node_id) REFERENCES node(node_id),
    FOREIGN KEY (geometry_id) REFERENCES geometry(geometry_id)
);