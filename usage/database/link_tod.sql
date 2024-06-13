CREATE TABLE IF NOT EXISTS link_tod (
    link_tod_id VARCHAR(255) NOT NULL,  -- Primary key
    link_id VARCHAR(255) NOT NULL,  -- Required. Foreign key, link table
    timeday_id VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
    time_day VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
    capacity FLOAT,  -- Optional. Capacity (veh / hr / lane)
    free_speed FLOAT,  -- Optional. Free flow speed in long_distance units per hour 
    lanes VARCHAR(255),  -- Optional. Number of permanent lanes (not including turn pockets) in the direction of travel open to motor vehicles. It does not include bike lanes, shoulders or parking lanes.
    bike_facility VARCHAR(255),  -- Optional. Types of bicycle accommodation based on the National Bikeway Network Data Template (Table 1-A at https://nmtdev.ornl.gov/assets/templates/NBN_DataTemplates_final.pdf)
    ped_facility VARCHAR(255),  -- Optional. Type of pedestrian accommodation: unknown, none, shoulder, sidewalk, offstreet path
    parking VARCHAR(255),  -- Optional. Type of parking: unknown, none, parallel, angle, other
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    toll FLOAT,  -- toll in currency units.
    PRIMARY KEY (link_tod_id),
    FOREIGN KEY (link_id) REFERENCES link(link_id),
    FOREIGN KEY (timeday_id) REFERENCES time_set_definitions(timeday_id)
);