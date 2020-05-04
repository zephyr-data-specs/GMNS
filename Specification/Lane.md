# lane

The lane file allocates portions of the physical right-of-way that might
be used for travel. It might be a travel lane, bike lane, or a parking
lane. Lanes can be determined by examining a high-resolution aerial
photo. Lanes only are included in directed links; undirected links are
assumed to have no lane controls or directionality. Lanes are uniquely
identified by:

  - Associated link

  - Lane number

If a lane is added, dropped, or changes properties along the link, those changes are recorded on the segment_link table.

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
pocket). Segments and segment_lanes are used to identify the places where lane
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
| link\_id     | Road\_Link\_ID |  Required | Foreign key, link\_id                                                                     |
| lane\_num | INTEGER        | Required                    | e.g., -1, 1, 2 (use left-to-right numbering)                                                    |
| allowed\_uses                               | Use\_Set       | Required                    | Set of allowed uses: SHOULDER, PARKING, WALK, ALL, BIKE, AUTO, HOV2, HOV3, TRUCK, BUS, etc.     |
| r_barrier                              | Barrier\_ID    | Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the right (default is NONE) |
| l_barrier                               | Barrier\_ID    | Optional                    | Whether a barrier exists to prevent vehicles from changing lanes to the left (default is NONE)  |
| width                                       | DOUBLE         | Optional                    | Width of the lane                                                                               |
| notes                                       | TEXT           | Optional                    |                                                                                                 |