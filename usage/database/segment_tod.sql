CREATE TABLE IF NOT EXISTS segment_tod (
    segment_tod_id VARCHAR(255) NOT NULL,  -- Primary key.
    segment_id VARCHAR(255) NOT NULL,  -- Foreign key to segment table.
    timeday_id VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
    time_day VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
    capacity FLOAT,  -- Optional. Capacity (veh/hr/ln)
    free_speed FLOAT,  -- Optional. Free flow speed in short_length units per hour 
    lanes VARCHAR(255),  -- Optional. Number of lanes in the direction of travel (must be consistent with link lanes + lanes added).
    l_lanes_added VARCHAR(255),  -- Optional. # of lanes added on the left of the road link (negative indicates a lane drop).
    r_lanes_added VARCHAR(255),  -- Optional. # of lanes added on the right of the road link (negative indicates a lane drop).
    bike_facility VARCHAR(255),  -- Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A at https://nmtdev.ornl.gov/assets/templates/NBN_DataTemplates_final.pdf)
    ped_facility VARCHAR(255),  -- Optional. Type of pedestrian accommodation: unknown,none,shoulder,sidewalk,offstreet_path.
    parking VARCHAR(255),  -- Optional. Type of parking: unknown,none,shoulder,sidewalk,offstreet_path.
    toll FLOAT,  -- Optional. Toll in currency units
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    PRIMARY KEY (segment_tod_id),
    FOREIGN KEY (segment_id) REFERENCES segment(segment_id),
    FOREIGN KEY (timeday_id) REFERENCES time_set_definitions(timeday_id)
);