## `segment_lane`
  - `description` Defines added and dropped lanes, and changes to lane parameters. If a lane is added, it has no parent. If it is changed or dropped, the parent_lane_id field keys to the associated lane on the lane table.
  - `path` segment_lane.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['segment_lane_id']
    - `foreignKeys`
      - [1]
        - `fields` ['segment_id']
        - `reference`
          - `resource` segment
          - `fields` ['segment_id']
    - `fieldsMatch` subset
  
| name            | type    | description                                                                                                         | constraints                                       | categories                         |
|:----------------|:--------|:--------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------|:-----------------------------------|
| segment_lane_id | any     | Primary key.                                                                                                        | {'required': True}                                |                                    |
| segment_id      | any     | Required. Foreign key to the associated segment.                                                                    | {'required': True}                                |                                    |
| lane_num        | integer | Required. -1, 1, 2 (use left-to-right numbering). 0 signifies a lane that is dropped on the segment.                | {'required': True, 'minimum': -10, 'maximum': 10} |                                    |
| parent_lane_id  | any     | Optional. If a lane drops or changes characteristics on the segment, the lane_id for that lane.                     |                                                   |                                    |
| allowed_uses    | string  | Optional. Set of allowed uses that should appear in either the use_definition or use_group tables; comma-separated. |                                                   |                                    |
| r_barrier       | string  | Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right (default is none)           |                                                   | ['none', 'regulatory', 'physical'] |
| l_barrier       | string  | Optional. Whether a barrier exists to prevent vehicles from changing lanes to the left (default is none)            |                                                   | ['none', 'regulatory', 'physical'] |
| width           | number  | Optional. Width of the lane (short_length units)                                                                    | {'minimum': 0}                                    |                                    |