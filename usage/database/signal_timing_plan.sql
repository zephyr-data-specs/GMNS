CREATE TABLE IF NOT EXISTS signal_timing_plan (
    timing_plan_id VARCHAR(255) NOT NULL,  -- Primary key.
    controller_id VARCHAR(255) NOT NULL,  -- Required. Foreign key (signal_controller table).
    timeday_id VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). Foreign key to time_set_definitions.
    time_day VARCHAR(255),  -- Conditionally required (either timeday_id or time_day). XXXXXXXX_HHMM_HHMM, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.
    cycle_length FLOAT,  -- Cycle length in seconds.
    PRIMARY KEY (timing_plan_id),
    FOREIGN KEY (controller_id) REFERENCES signal_controller(controller_id),
    FOREIGN KEY (timeday_id) REFERENCES time_set_definitions(timeday_id)
);