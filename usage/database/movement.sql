CREATE TABLE IF NOT EXISTS movement (
    mvmt_id VARCHAR(255) NOT NULL,  -- Primary key.
    node_id VARCHAR(255) NOT NULL,  -- The node representing the junction.
    name VARCHAR(255),  -- Optional.
    ib_link_id VARCHAR(255) NOT NULL,  -- Inbound link id.
    start_ib_lane VARCHAR(255),  -- Innermost lane number the movement applies to at the inbound end.
    end_ib_lane VARCHAR(255),  -- Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.
    ob_link_id VARCHAR(255) NOT NULL,  -- Outbound link id.
    start_ob_lane VARCHAR(255),  -- Innermost lane number the movement applies to at the outbound end.
    end_ob_lane VARCHAR(255),  -- Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.
    type VARCHAR(255) NOT NULL,  -- Optional. Describes the type of movement (left, right, thru, etc.).
    penalty FLOAT,  -- Turn penalty (seconds)
    capacity FLOAT,  -- Capacity in vehicles per hour.
    ctrl_type VARCHAR(255),  -- Optional. .
    mvmt_code VARCHAR(255),  -- Optional. Movement code (e.g., SBL).  Syntax is DDTN, where DD is the direction (e.g., SB, NB, EB, WB, NE, NW, SE, SW). T is the turning movement (e.g., R, L, T) and N is an optional turning movement number (e.g., distinguishing between bearing right and a sharp right at a 6-way intersection)
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    geometry VARCHAR(255),  -- Optional. Movement geometry, in well-known text (WKT) format. Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json
    PRIMARY KEY (mvmt_id),
    FOREIGN KEY (node_id) REFERENCES node(node_id),
    FOREIGN KEY (ib_link_id) REFERENCES link(link_id),
    FOREIGN KEY (ob_link_id) REFERENCES link(link_id)
);