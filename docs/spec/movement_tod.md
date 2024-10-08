## `movement_tod`
  - `description` Handles day-of-week and time-of-day restrictions on movements.
  - `path` movement_tod.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['mvmt_tod_id']
    - `foreignKeys`
      - [1]
        - `fields` ['mvmt_id']
        - `reference`
          - `resource` movement
          - `fields` ['mvmt_id']
      - [2]
        - `fields` ['timeday_id']
        - `reference`
          - `resource` time_set_definitions
          - `fields` ['timeday_id']
      - [3]
        - `fields` ['ib_link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
      - [4]
        - `fields` ['ob_link_id']
        - `reference`
          - `resource` link
          - `fields` ['link_id']
    - `fieldsMatch` subset
  
| name          | type    | description                                                                                                                                                                                                                                                                                           | constraints        | categories                                                                                |
|:--------------|:--------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------|:------------------------------------------------------------------------------------------|
| mvmt_tod_id   | any     | Primary key.                                                                                                                                                                                                                                                                                          | {'required': True} |                                                                                           |
| mvmt_id       | any     | The referenced movement.                                                                                                                                                                                                                                                                              | {'required': True} |                                                                                           |
| time_day      | string  | Time of day in XXXXXXXX_HHMM_HHMM format, where XXXXXXXX is a bitmap of days of the week, Sunday-Saturday, Holiday. The HHMM are the start and end times.                                                                                                                                             |                    |                                                                                           |
| timeday_id    | any     | Time of day set. Used if times-of-day are defined on the time_set_definitions table                                                                                                                                                                                                                   |                    |                                                                                           |
| ib_link_id    | any     | Inbound link id.                                                                                                                                                                                                                                                                                      | {'required': True} |                                                                                           |
| start_ib_lane | integer | Innermost lane number the movement applies to at the inbound end.                                                                                                                                                                                                                                     |                    |                                                                                           |
| end_ib_lane   | integer | Outermost lane number the movement applies to at the inbound end. Blank indicates a movement with a single inbound lane.                                                                                                                                                                              |                    |                                                                                           |
| ob_link_id    | any     | Outbound link id.                                                                                                                                                                                                                                                                                     | {'required': True} |                                                                                           |
| start_ob_lane | integer | Innermost lane number the movement applies to at the outbound end.                                                                                                                                                                                                                                    |                    |                                                                                           |
| end_ob_lane   | integer | Outermost lane number the movement applies to at the outbound end. Blank indicates a movement with a single outbound lane.                                                                                                                                                                            |                    |                                                                                           |
| type          | string  | Optional. Describes the type of movement (left, right, thru, etc.).                                                                                                                                                                                                                                   | {'required': True} | ['left', 'right', 'uturn', 'thru', 'merge']                                               |
| penalty       | number  | Turn penalty (seconds)                                                                                                                                                                                                                                                                                |                    |                                                                                           |
| capacity      | number  | Saturation capacity in passenger car equivalents per hour.                                                                                                                                                                                                                                            |                    |                                                                                           |
| ctrl_type     | any     | Optional. .                                                                                                                                                                                                                                                                                           |                    | ['no_control', 'yield', 'stop', 'stop_2_way', 'stop_4_way', 'signal_with_RTOR', 'signal'] |
| mvmt_code     | string  | Optional. Movement code (e.g., SBL).  Syntax is DDTN, where DD is the direction (e.g., SB, NB, EB, WB, NE, NW, SE, SW). T is the turning movement (e.g., R, L, T) and N is an optional turning movement number (e.g., distinguishing between bearing right and a sharp right at a 6-way intersection) |                    |                                                                                           |
| allowed_uses  | string  | Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated.                                                                                                                                                                                   |                    |                                                                                           |