# segment_lane

The segment_lane table defines added and dropped lanes, and changes to lane parameters. If a lane is added, it has no parent. If it is changed or dropped, the parent_lane_id field keys to the associated lane on the lane table.

lane data dictionary

| Field                                       | Type           | Required?                   | Comment                                                                                         |
| ------------------------------------------- | -------------- | --------------------------- | ----------------------------------------------------------------------------------------------- |
| lane\_id     | Lane\_ID       | Required                    | Primary key                                                                                     |
| link\_id     | Link\_ID |  Required | Foreign key, link\_id                                                                     |
| segment\_id  | Segment\_ID    |  Required      | Foreign key, associated segment  |
| lane\_num | INTEGER        | Required                    | e.g., -1, 1, 2 (use left-to-right numbering). 0 signifies a lane that is dropped on the segment.                                                    |
| parent_lane_id | Lane\_ID | Optional | If a lane drops or changes characteristics on the segment, the lane_id for that lane. |
| allowed\_uses                               | Use\_Set       | Required                    | Set of allowed uses: SHOULDER, PARKING, WALK, ALL, BIKE, AUTO, HOV2, HOV3, TRUCK, BUS, etc.     |
| r_barrier                              | Barrier\_ID    | Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the right (default is NONE) |
| l_barrier                               | Barrier\_ID    | Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the left (default is NONE)  |
| width                                       | DOUBLE         | Optional                    | Width of the lane                                                                               |
| notes                                       | TEXT           | Optional                    |                                                                                                 |
