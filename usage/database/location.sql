CREATE TABLE IF NOT EXISTS location (
    loc_id VARCHAR(255) NOT NULL,  -- Primary key. Location ID.
    link_id VARCHAR(255) NOT NULL,  -- Required. Road Link ID. Foreign Key from Road_Link.
    ref_node_id VARCHAR(255) NOT NULL,  -- Required. The From node of the link. Foreign Key from Node.
    lr FLOAT NOT NULL,  -- Required. Linear Reference of the location, measured as distance in short_length units along the link from the reference node.  If link_geometry exists, it is used. Otherwise, link geometry is assumed to be a crow-fly distance from A node to B node.
    x_coord FLOAT,  -- Optional. Either provided, or derived from Link, Ref_Node and LR.
    y_coord FLOAT,  -- Optional. Either provided, or derived from Link, Ref_Node and LR.
    z_coord FLOAT,  -- Optional. Altitude in short_length units.
    loc_type VARCHAR(255),  -- Optional. What it represents (driveway, bus stop, etc.) OpenStreetMap map feature names are recommended.
    zone_id VARCHAR(255),  -- Optional. Foreign Key, Associated zone
    gtfs_stop_id VARCHAR(255),  -- Optional. Foreign Key to GTFS data. For bus stops and transit station entrances, provides a link to the General Transit Feed Specification.
    PRIMARY KEY (loc_id),
    FOREIGN KEY (link_id) REFERENCES link(link_id),
    FOREIGN KEY (ref_node_id) REFERENCES node(node_id)
);