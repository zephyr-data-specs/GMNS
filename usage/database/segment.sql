CREATE TABLE IF NOT EXISTS segment (
    segment_id VARCHAR(255) NOT NULL,  -- Primary key.
    link_id VARCHAR(255) NOT NULL,  -- Required. Foreign key to road_links. The link that the segment is located on.
    ref_node_id VARCHAR(255) NOT NULL,  -- Required. Foreign key to node where distance is 0.
    start_lr FLOAT NOT NULL,  -- Required. Distance from `ref_node_id` in short_length units.
    end_lr FLOAT NOT NULL,  -- Required. Distance from `ref_node_id`in short_length units.
    grade FLOAT,  -- % grade, negative is downhill
    capacity FLOAT,  -- Optional. Capacity (veh/hr/ln)
    free_speed FLOAT,  -- Optional. Free flow speed, units defined by config file
    lanes VARCHAR(255),  -- Optional. Number of lanes in the direction of travel (must be consistent with link lanes + lanes added).
    l_lanes_added VARCHAR(255),  -- Optional. # of lanes added on the left of the road link (negative indicates a lane drop).
    r_lanes_added VARCHAR(255),  -- Optional. # of lanes added on the right of the road link (negative indicates a lane drop).
    bike_facility VARCHAR(255),  -- Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A at https://nmtdev.ornl.gov/assets/templates/NBN_DataTemplates_final.pdf)
    ped_facility VARCHAR(255),  -- Optional. Type of pedestrian accommodation:unknown,none,shoulder,sidewalk,offstreet_path.
    parking VARCHAR(255),  -- Optional. Type of parking: unknown,none,shoulder,sidewalk,offstreet_path.
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    toll FLOAT,  -- Optional.  Toll on the segment, in currency units.
    jurisdiction VARCHAR(255),  -- Optional. Optional.  Owner/operator of the segment.
    row_width FLOAT,  -- Optional. Width (short_length units) of the entire right-of-way (both directions).
    PRIMARY KEY (segment_id),
    FOREIGN KEY (link_id) REFERENCES link(link_id),
    FOREIGN KEY (ref_node_id) REFERENCES node(node_id)
);