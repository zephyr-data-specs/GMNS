CREATE TABLE IF NOT EXISTS lane (
    lane_id VARCHAR(255) NOT NULL,  -- Primary key
    link_id VARCHAR(255) NOT NULL,  -- Required. Foreign key to link table.
    lane_num VARCHAR(255) NOT NULL,  -- Required. e.g., -1, 1, 2 (use left-to-right numbering).
    allowed_uses VARCHAR(255),  -- Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.
    r_barrier VARCHAR(255),  -- Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
    l_barrier VARCHAR(255),  -- Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right.<br>- `none` (the default). Indicates that a vehicle can change lanes, provided that the vehicle-type is permitted in the destination lane<br>- `regulatory`. There is a regulatory prohibition (e.g., a double-white solid line) against changing lanes, but no physical barrier<br>- `physical`. A physical barrier (e.g., a curb, Jersey barrier) is in place.
    width FLOAT,  -- Optional. Width of the lane, short_length units.
    PRIMARY KEY (lane_id),
    FOREIGN KEY (link_id) REFERENCES link(link_id)
);