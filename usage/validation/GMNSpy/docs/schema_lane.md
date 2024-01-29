# lane

|name|required|type|foreign_key|description|constraints minimum|
|---|---|---|---|---|---|
|lane_id|True|any|-|Primary key|-|
|road_link_id|-|any|-|Conditionally Required. Foreign key  to  road_link table.|-|
|segment_id|-|any|-|Conditionally Required. Associated segment (Blank = lane traverses entire link) Foreign key (Segment table).|-|
|lane_num|True|integer|-|Required. e.g., -1, 1, 2 (use left-to-right numbering).|-|
|allowed_uses|True|string|-|Required. Set of allowed uses from Use_set: SHOULDER, PARKING, WALK, ALL, BIKE, AUTO, HOV2, HOV3, TRUCK, BUS, etc.|-|
|r_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the right (default is None)|-|
|l_barrier|-|any|-|Optional. Whether a barrier exists to prevent vehicles from changing lanes to the left (default is None)|-|
|width|-|number|-|Optional. Width of the lane,feet.|0|
|notes|-|string|-|Optional.|-|
