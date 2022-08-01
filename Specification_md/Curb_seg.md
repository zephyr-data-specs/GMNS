## Curb_seg

A curb segment is a portion of a link, used to define curbside regulations.  It is not used to change how the link is used for travel (e.g., changes to the number of travel lanes).  For the latter, segments and lanes should be used.  The following fields are used to define a curb_seg:

  - link\_id

  - ref\_node_id, the node from which the linear referencing starts (typically the from_node of the link)

  - start\_lr, the start of the segment, measured as distance from
    the ref\_node

  - end\_lr, the end of the segment, measured as distance from the
    ref\_node
	
curb_seg data dictionary

| Field 	  | Type   | Required |  Comment                                           | 
|-------------|--------|----------|----------------------------------------------------|
| curb_seg_id | any    | Required | Primary key.                                       | 
| link_id     | any    | Required | link.link_id                                       | 
| ref_node_id | any    | Required | node.node_id                                       | 
| start_lr    | number | Required | Distance from `ref_node_id` in short_length units. | 
| end_lr      | number | Required | Distance from `ref_node_id`in short_length units.  | 
| regulation  | string | Optional | Regulation on this curb segment.                   |
| width       | number | Optional | Width (short_length units) of the curb lane.    | 