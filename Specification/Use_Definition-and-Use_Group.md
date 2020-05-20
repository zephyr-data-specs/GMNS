Two classes define the characteristics of each use, and of the items in a use set.  

## Use_Definition
The __Use_Definition__ file defines the characteristics of each vehicle type or non-travel purpose (e.g., a shoulder or parking lane). A two-way left
turn lane (TWLTL) is also a use.

Field | Type | Required? | Comment
---|---|---|---
use | TEXT | Required | Short name of the vehicle, e.g., AUTO, HOV2, HOV3+, BUS, TRUCK, BIKE, WALK, TWLTL, PARKING
persons_per_vehicle | DOUBLE | Required | Average persons per vehicle.  Used to compute person-based performance measures (0 for non-travel uses)
pce | DOUBLE | Required | Passenger car equivalents, used for capacity calculations (0 for non-travel uses)
special_conditions | TEXT | Optional | In some situations, the characteristics of a mode may change depending on the type of link where the mode is operating.  For example, a truck may have a higher PCE on a hill.  Treatment of these special conditions may be needed in a future version of GMNS
description | TEXT | Optional | A longer description of the mode

## Use_Group
The optional __Use_Group__ file defines groupings of uses, to reduce the size of the Allowed_Uses lists in the other tables.  

Field | Type | Required? | Comment
---|---|---|---
use_group | TEXT | Required | Short name of the group, e.g., ALL, MV
uses | TEXT | Required | List of uses (or nested groups) in each group
description | TEXT | Optional | Description of the group

Examples include:  
 
use_group | uses             | description                 
-------- | ---------------- | ---------------------------  
AUTO     | SOV, HOV2, HOV3+ | all automobiles             
HOV      | HOV2, HOV3+, BUS | all high occupancy vehicles  
MV       | AUTO, BUS, TRUCK | all motor vehicles          