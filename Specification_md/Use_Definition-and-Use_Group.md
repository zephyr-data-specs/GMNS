Two classes define the characteristics of each use, and of the items in a use set.  

## use_definition
The __use_definition__ file defines the characteristics of each vehicle type or non-travel purpose (e.g., a shoulder or parking lane). A two-way left
turn lane (TWLTL) is also a use.

Field | Type | Required? | Comment
---|---|---|---
use | TEXT | Required | Short name of the vehicle, e.g., auto, hov2, hov3+, bus, truck, bike, walk, twltl, parking
persons_per_vehicle | DOUBLE | Required | Average persons per vehicle.  Used to compute person-based performance measures (0 for non-travel uses)
pce | DOUBLE | Required | Passenger car equivalents, used for capacity calculations (0 for non-travel uses)
special_conditions | TEXT | Optional | In some situations, the characteristics of a mode may change depending on the type of link where the mode is operating.  For example, a truck may have a higher PCE on a hill.  Treatment of these special conditions may be needed in a future version of GMNS
description | TEXT | Optional | A longer description of the mode

## use_group
The optional __use_group__ file defines groupings of uses, to reduce the size of the Allowed_Uses lists in the other tables.  

Field | Type | Required? | Comment
---|---|---|---
use_group | TEXT | Required | Short name of the group, e.g., all, mv
uses | TEXT | Required | List of uses (or nested groups) in each group
description | TEXT | Optional | Description of the group

Examples include:  
 
use_group | uses             | description                 
-------- | ---------------- | ---------------------------  
auto     | sov, hov2, hov3+ | all automobiles             
hov      | hov2, hov3+, bus | all high occupancy vehicles  
mv       | auto, bus, truck | all motor vehicles          
