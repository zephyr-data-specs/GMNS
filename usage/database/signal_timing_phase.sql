CREATE TABLE IF NOT EXISTS signal_timing_phase (
    timing_phase_id VARCHAR(255) NOT NULL,  -- Primary key.
    timing_plan_id VARCHAR(255),  -- Foreign key; connects to a timing_plan associated with a controller.
    signal_phase_num VARCHAR(255) NOT NULL,  -- Signal phase number. Typically the NEMA phase number.
    min_green FLOAT,  -- The minimum green time in seconds for an actuated signal. Green time in seconds for a fixed time signal.
    max_green FLOAT,  -- Optional.The maximum green time in seconds for an actuated signal; the default is minimum green plus one extension
    extension FLOAT,  -- Optional. The number of seconds the green time is extended each time vehicles are detected.
    clearance FLOAT,  -- Yellow interval plus all red interval
    walk_time FLOAT,  -- If a pedestrian phase exists, the walk time in seconds
    ped_clearance FLOAT,  -- If a pedestrian phase exists, the flashing don't walk time.
    ring VARCHAR(255) NOT NULL,  -- Required. Set of phases that conflict with each other. 
    barrier VARCHAR(255) NOT NULL,  -- Required. Set of phases that can operate other.
    position VARCHAR(255) NOT NULL,  -- Required. Position.
    PRIMARY KEY (timing_phase_id),
    FOREIGN KEY (timing_plan_id) REFERENCES signal_timing_plan(timing_plan_id)
);