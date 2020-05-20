# General Modeling Network Specification

## Configuration
The following units are recommended:
- Short lengths (linear references, lane widths, etc.): feet
- Long lengths (link lengths): miles
- Speed: miles per hour

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
- [link_lane_tod](TOD.md#link_lane_tod)  
- [segment_lane_tod](TOD.md#segment_lane_tod)  
- [movement](Movement-and-Movement_TOD.md#Movement)  
- [movement_tod](Movement-and-Movement_TOD.md#Movement_TOD)  
- [signal_phase](Signals.md#Signal_Phase)  
- [signal_phase_concurrency](Signals.md#Signal_Phase_Concurrency)  
- [signal_timing_plan](Signals.md#Signal_Timing_Plan)
- [signal_timing_phase](Signals.md#Signal_Timing_Phase)  