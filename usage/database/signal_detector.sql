CREATE TABLE IF NOT EXISTS signal_detector (
    detector_id VARCHAR(255) NOT NULL,  -- Primary key.
    controller_id VARCHAR(255) NOT NULL,  -- Required. Foreign key to signal_controller table.
    signal_phase_num VARCHAR(255) NOT NULL,  -- Required. Number of the associated phase.
    link_id VARCHAR(255) NOT NULL,  -- Foreign key. The link covered by the detector.
    start_lane VARCHAR(255) NOT NULL,  -- Left-most lane covered by the detector.
    end_lane VARCHAR(255),  -- Right-most lane covered by the detector (blank if only one lane).
    ref_node_id VARCHAR(255) NOT NULL,  -- The detector is on the approach to this node.
    det_zone_lr FLOAT NOT NULL,  -- Required. Distance from from the stop bar to detector in short_length units.
    det_zone_front FLOAT,  -- Optional. Linear reference of front of detection zone in short_length units.
    det_zone_back FLOAT,  -- Optional. Linear reference of back of detection zone in short_length units.
    det_type VARCHAR(255),  -- Optional. Type of detector.
    PRIMARY KEY (detector_id),
    FOREIGN KEY (controller_id) REFERENCES signal_controller(controller_id),
    FOREIGN KEY (link_id) REFERENCES link(link_id),
    FOREIGN KEY (ref_node_id) REFERENCES node(node_id)
);