CREATE TABLE IF NOT EXISTS signal_phase_mvmt (
    signal_phase_mvmt_id VARCHAR(255) NOT NULL,  -- Primary key.
    timing_phase_id VARCHAR(255) NOT NULL,  -- Associated entry in the timing phase table.
    mvmt_id VARCHAR(255),  -- Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required.
    link_id VARCHAR(255),  -- Foreign key. Either Movement_ID (for phases used by vehicles), or Link_id (for phases used by pedestrians) is required.
    protection VARCHAR(255),  -- Optional. Indicates whether the phase is protected, permitted, or right turn on red.
    PRIMARY KEY (signal_phase_mvmt_id),
    FOREIGN KEY (timing_phase_id) REFERENCES signal_timing_phase(timing_phase_id),
    FOREIGN KEY (mvmt_id) REFERENCES movement(mvmt_id),
    FOREIGN KEY (link_id) REFERENCES link(link_id)
);