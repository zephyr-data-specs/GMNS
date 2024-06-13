CREATE TABLE IF NOT EXISTS segment_lane_tod (
    segment_lane_tod_id VARCHAR(255) NOT NULL,  -- Primary key.
    segment_lane_id VARCHAR(255) NOT NULL,  -- Required. Foreign key, segment_lane table
    timeday_id VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
    time_day VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
    lane_num VARCHAR(255) NOT NULL,  -- Required. Lane number identified as offset to the right from the centerline. i.e. -1, 1, 2 (use left-to-rightnumbering).
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    r_barrier VARCHAR(255),  -- Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
    l_barrier VARCHAR(255),  -- Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `Regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `Physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
    width FLOAT,  -- Optional. Width of the lane, short_length units.
    PRIMARY KEY (segment_lane_tod_id),
    FOREIGN KEY (segment_lane_id) REFERENCES segment_lane(segment_lane_id),
    FOREIGN KEY (timeday_id) REFERENCES time_set_definitions(timeday_id)
);