# segment_lane

The segment_lane table defines added and dropped lanes, and changes to lane parameters. If a lane is added, it has no parent. If it is changed or dropped, the parent_lane_id field keys to the associated lane on the lane table.

segment_lane data dictionary

| Field                                       | Type           | Required?                   | Comment                                                                                         |
| ------------------------------------------- | -------------- | --------------------------- | ----------------------------------------------------------------------------------------------- |
| segment\_lane\_id     | Segment\_Lane\_ID       | Required                    | Primary key                                                |
| segment\_id  | Segment\_ID    |  Required      | Foreign key, associated segment  |
| lane\_num | INTEGER        | Required                    | e.g., -1, 1, 2 (use left-to-right numbering). 0 signifies a lane that is dropped on the segment.                                                    |
| parent_lane_id | Lane\_ID | Optional | If a lane drops or changes characteristics on the segment, the lane_id for that lane. |
| allowed\_uses                               | Use\_Set       | Required                    | Set of allowed uses: shoulder, parking, walk, all, bike, auto, hov2, hov3, truck, bus, etc.     |
| r_barrier                              | text | Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the right (default is none) |
| l_barrier                               | text| Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the left (default is none)  |
| width                                       | DOUBLE         | Optional                    | Width of the lane                                                                               |
