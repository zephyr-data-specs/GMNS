CREATE TABLE IF NOT EXISTS signal_coordination (
    coordination_id VARCHAR(255) NOT NULL,  -- Primary key.
    timing_plan_id VARCHAR(255) NOT NULL,  -- Required. Foreign key (Signal_timing_plan table).
    controller_id VARCHAR(255) NOT NULL,  -- Required. Foreign key (signal_controller table).
    coord_contr_id VARCHAR(255),  -- Optional. For coordinated signals, the master signal controller for coordination.
    coord_phase VARCHAR(255),  -- Optional. For coordinated signals, the phase at which coordination starts (time 0).
    coord_ref_to VARCHAR(255),  -- Optional. For coordinated signals, the part of the phase where coordination starts: begin_of_green, begin_of_yellow, begin_of_red.
    offset FLOAT,  -- Optional. Offset in seconds.
    PRIMARY KEY (coordination_id),
    FOREIGN KEY (timing_plan_id) REFERENCES signal_timing_plan(timing_plan_id),
    FOREIGN KEY (controller_id) REFERENCES signal_controller(controller_id),
    FOREIGN KEY (coord_contr_id) REFERENCES signal_controller(controller_id)
);