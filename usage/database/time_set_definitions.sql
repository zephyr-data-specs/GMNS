CREATE TABLE IF NOT EXISTS time_set_definitions (
    timeday_id VARCHAR(255) NOT NULL,  -- Primary key.Primary key, similar to `service_id` in GTFS. Unique name of the time of day. Preferable legible rather than a number.
    monday VARCHAR(255) NOT NULL,  -- Required. Whether Mondays are included.
    tuesday VARCHAR(255) NOT NULL,  -- Required. Whether Tuesdays are included.
    wednesday VARCHAR(255) NOT NULL,  -- Required. Whether Wednesdays are included.
    thursday VARCHAR(255) NOT NULL,  -- Required. Whether Thursdays are included.
    Friday VARCHAR(255) NOT NULL,  -- Required. Whether Fridays are included.
    saturday VARCHAR(255) NOT NULL,  -- Required. Whether Saturdays are included.
    sunday VARCHAR(255) NOT NULL,  -- Required. Whether Sundays are included.
    holiday VARCHAR(255) NOT NULL,  -- Required. Whether holidays are included.
    start_time VARCHAR(255) NOT NULL,  -- Required. Start time in HH:MM format.
    end_time VARCHAR(255) NOT NULL,  -- Required. End  time in HH:MM format.
    PRIMARY KEY (timeday_id)
);