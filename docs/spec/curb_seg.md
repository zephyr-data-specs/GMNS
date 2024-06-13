## `schema`

| name        | type   | description                                                                   | constraints                      |
|:------------|:-------|:------------------------------------------------------------------------------|:---------------------------------|
| curb_seg_id | any    | Primary key.                                                                  | {'required': True}               |
| link_id     | any    | Required. Foreign key to road_links. The link that the segment is located on. | {'required': True}               |
| ref_node_id | any    | Required. Foreign key to node where distance is 0.                            | {'required': True}               |
| start_lr    | number | Required. Distance from `ref_node_id` in short_length units.                  | {'required': True, 'minimum': 0} |
| end_lr      | number | Required. Distance from `ref_node_id`in short_length units.                   | {'required': True, 'minimum': 0} |
| regulation  | string | Optional. Regulation on this curb segment.                                    |                                  |
| width       | number | Optional. Width (short_length units) of the curb segment.                     | {'minimum': 0}                   |