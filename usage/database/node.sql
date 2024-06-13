CREATE TABLE IF NOT EXISTS node (
    node_id VARCHAR(255) NOT NULL,  -- Primary key
    name VARCHAR(255),  -- 
    x_coord FLOAT NOT NULL,  -- Coordinate system specified in config file (longitude, UTM-easting etc.)
    y_coord FLOAT NOT NULL,  -- Coordinate system specified in config file (latitude, UTM-northing etc.)
    z_coord FLOAT,  -- Optional. Altitude in short_length units.
    node_type VARCHAR(255),  -- Optional. What it represents (intersection, transit station, park & ride).
    ctrl_type VARCHAR(255),  -- Optional. Intersection control type - one of ControlType_Set.
    zone_id VARCHAR(255),  -- Optional. Could be a Transportation Analysis Zone (TAZ) or city, or census tract, or census block.
    parent_node_id VARCHAR(255),  -- Optional. Associated node. For example, if this node is a sidewalk, a parent_nodek_id could represent the intersection  it is associated with.
    PRIMARY KEY (node_id),
    FOREIGN KEY (zone_id) REFERENCES zone(zone_id),
    FOREIGN KEY (parent_node_id) REFERENCES (node_id)
);