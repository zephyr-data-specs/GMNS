## `schema`

| name             | type    | description                                                                  | constraints        |
|:-----------------|:--------|:-----------------------------------------------------------------------------|:-------------------|
| detector_id      | any     | Primary key.                                                                 | {'required': True} |
| controller_id    | any     | Required. Foreign key to signal_controller table.                            | {'required': True} |
| signal_phase_num | integer | Required. Number of the associated phase.                                    | {'required': True} |
| link_id          | any     | Foreign key. The link covered by the detector.                               | {'required': True} |
| start_lane       | integer | Left-most lane covered by the detector.                                      | {'required': True} |
| end_lane         | integer | Right-most lane covered by the detector (blank if only one lane).            |                    |
| ref_node_id      | any     | The detector is on the approach to this node.                                | {'required': True} |
| det_zone_lr      | number  | Required. Distance from from the stop bar to detector in short_length units. | {'required': True} |
| det_zone_front   | number  | Optional. Linear reference of front of detection zone in short_length units. |                    |
| det_zone_back    | number  | Optional. Linear reference of back of detection zone in short_length units.  |                    |
| det_type         | string  | Optional. Type of detector.                                                  |                    |