# General Modeling Network Specification

## Configuration
The following units are recommended:
- Short lengths (linear references, lane widths, etc.): feet or meters
- Long lengths (link lengths): miles or km
- Speed: miles per hour or km / hr
These are defined for each dataset in the [config](Config.md) file.

The specification also provides for optional tables to define datatypes for use and time sets:
- [use_definition and use_group](Use_Definition-and-Use_Group.md)  
- [time_set_definitions](TOD.md#time_set_definitions)

## Specification Tables
### Basic Data Elements
- [node](Node.md)  
- [link](Link.md)
- [geometry](Geometry.md)       
- [zone](Zone.md)
### Advanced Data Elements
- [segment](Segment.md)  
- [location](Location.md)  
- [lane](Lane.md)  
- [segment_lane](Segment_lane.md)
- [link_tod](TOD.md#Link_TOD)  
- [segment_tod](TOD.md#segment_tod)  
- [lane_tod](TOD.md#lane_tod)  
- [segment_lane_tod](TOD.md#segment_lane_tod)  
- [movement](Movement-and-Movement_TOD.md#Movement)  
- [movement_tod](Movement-and-Movement_TOD.md#Movement_TOD) 
- [signal_controller](Signals.md#signal_controller)
- [signal_coordination](Signals.md#signal_coordination)
- [signal_detector](Signals.md#signal_detector)  
- [signal_phase_mvmt](Signals.md#signal_phase_mvmt)  
- [signal_timing_plan](Signals.md#signal_timing_plan)
- [signal_timing_phase](Signals.md#signal_timing_phase)

## Inheritance relationships
![Inheritance relationships](../Images/inheritance.png)
