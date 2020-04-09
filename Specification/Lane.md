# lane

The lane file allocates portions of the physical right-of-way that might
be used for travel. It might be a travel lane, bike lane, or a parking
lane. Lanes can be determined by examining a high-resolution aerial
photo. Lanes only are included in road\_links; offroad\_links are
assumed to have no lane controls or directionality. Lanes are uniquely
identified in one of two ways:

If it is on a segment of a road\_link

  - Associated segment

  - Lane number

If it is not on a segment of a road\_link (i.e., it traverses the entire
link)

  - Associated link

  - Lane number

Lanes are numbered sequentially, starting at either the centerline (on a
two-way street) or the left shoulder (on a one-way street or divided
highway with two centerlines), and ascending towards the right edge of
the road. In cases where lanes are numbered starting at the centerline
(which most often occurs on a two-way undivided road), the centerline
itself is treated as lane 0, with 0 width. In this case, lane that is on
the opposing traffic side of the centerline (e.g., a peak hour
contra-flow lane or a left turn lane), may be numbered as -1. If there
are dual-left turn lanes on the opposing traffic side of the centerline,
they may be labeled -2 and -1.

![Depicts lanes, with lane -1 to the left of the centerline, and lanes 1, 2, 3 to
the right of the centerline_](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/spec_figure1.png)  
_Lanes leading to an intersection._ Source: MATSim documentation (2016), with text added by Volpe. 

It is challenging to represent a lane that has different purposes on
different sections of a lane (e.g., a merge lane downstream of a signal,
which then becomes a parking lane, and then becomes a right-turn
pocket). Segments are used to identify the places where lane
transitions occur.

The lane file includes the typical allocation of lanes. It does not
include special time-of-day restrictions. These are covered in the
optional link\_tod file.

To enable special purpose lanes (e.g., car pool, separated bicycle) to
be coded without use of a separate link, optional Barrier fields
indicate whether a vehicle can move to the right, or to the left out of
a lane. Values for the Barrier field include

  - None (the default). Indicates that a vehicle can change lanes,
    provided that the vehicle-type is permitted in the destination lane

  - Regulatory. There is a regulatory prohibition (e.g., a double-white
    solid line) against changing lanes, but no physical barrier

  - Physical. A physical barrier (e.g., a curb, Jersey barrier) is in
    place.

lane data dictionary

| Field                                       | Type           | Required?                   | Comment                                                                                         |
| ------------------------------------------- | -------------- | --------------------------- | ----------------------------------------------------------------------------------------------- |
| lane\_id     | Lane\_ID       | Required                    | Primary key                                                                                     |
| road_link\_id     | Road\_Link\_ID | Conditionally Required (See note) | Foreign key, Road\_link\_id                                                                     |
| segment\_id  | Segment\_ID    | Conditionally Required      | Associated segment (Blank = lane traverses entire link) Foreign key (Segment table)             |
| lane\_num | INTEGER        | Required                    | e.g., -1, 1, 2 (use left-to-right numbering)                                                    |
| allowed\_uses                               | Use\_Set       | Required                    | Set of allowed uses: SHOULDER, PARKING, WALK, ALL, BIKE, AUTO, HOV2, HOV3, TRUCK, BUS, etc.     |
| r_barrier                              | Barrier\_ID    | Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the right (default is NONE) |
| l_barrier                               | Barrier\_ID    | Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the left (default is NONE)  |
| width                                       | DOUBLE         | Optional                    | Width of the lane                                                                               |
| notes                                       | TEXT           | Optional                    |                                                                                                 |

Note: Either the link_id OR the segment_id are required. When segment_id is used, link_id is still recommended (for human readability). 

## Relationships
![Relationships with the Lane table](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/ER_diagrams/lane.png)