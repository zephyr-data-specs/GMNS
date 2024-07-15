## `time_set_definitions`
  - `description` The time_set_definitions file is an optional representation of time-of-day and day-of-week sets to enable time restrictions through `_tod` files.
  - `path` time_set_definitions.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['timeday_id']
    - `fieldsMatch` subset
  
| name       | type    | description                                                                                                                        | constraints        |
|:-----------|:--------|:-----------------------------------------------------------------------------------------------------------------------------------|:-------------------|
| timeday_id | any     | Primary key.Primary key, similar to `service_id` in GTFS. Unique name of the time of day. Preferable legible rather than a number. | {'required': True} |
| monday     | boolean | Required. Whether Mondays are included.                                                                                            | {'required': True} |
| tuesday    | boolean | Required. Whether Tuesdays are included.                                                                                           | {'required': True} |
| wednesday  | boolean | Required. Whether Wednesdays are included.                                                                                         | {'required': True} |
| thursday   | boolean | Required. Whether Thursdays are included.                                                                                          | {'required': True} |
| Friday     | boolean | Required. Whether Fridays are included.                                                                                            | {'required': True} |
| saturday   | boolean | Required. Whether Saturdays are included.                                                                                          | {'required': True} |
| sunday     | boolean | Required. Whether Sundays are included.                                                                                            | {'required': True} |
| holiday    | boolean | Required. Whether holidays are included.                                                                                           | {'required': True} |
| start_time | time    | Required. Start time in HH:MM format.                                                                                              | {'required': True} |
| end_time   | time    | Required. End  time in HH:MM format.                                                                                               | {'required': True} |