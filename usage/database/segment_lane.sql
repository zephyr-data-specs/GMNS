CREATE TABLE IF NOT EXISTS segment_lane (
    segment_lane_id VARCHAR(255) NOT NULL,  -- Primary key.
    segment_id VARCHAR(255) NOT NULL,  -- Required. Foreign key to the associated segment.
    lane_num VARCHAR(255) NOT NULL,  -- Required. -1, 1, 2 (use left-to-right numbering). 0 signifies a lane that is dropped on the segment.
    parent_lane_id VARCHAR(255),  -- Optional. If a lane drops or changes characteristics on the segment, the lane_id for that lane.
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    r_barrier VARCHAR(255),  -- Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right (default is none)
    l_barrier VARCHAR(255),  -- Optional. Whether a barrier exists to prevent vehicles from changing lanes to the left (default is none)
    width FLOAT,  -- Optional. Width of the lane (short_length units)
    PRIMARY KEY (segment_lane_id),
    FOREIGN KEY (segment_id) REFERENCES segment(segment_id)
);