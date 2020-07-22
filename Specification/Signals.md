#	Signals	

Representation of traffic controls (e.g., stop signs, signals, etc.) includes several considerations:  
- For static networks, the node may include the type of traffic control (e.g., unknown, no control, yield, 4-way stop, signal, 2-way stop, roundabout)
- The link includes functional class and number of lanes
- With basic information on the node and link, a reasonable approximation of traffic control configuration (e.g., which approach is being stopped) for static models can be made from the above information
- For dynamic models, basic control information can be included in the movement file.  Controls include unknown, no control, yield, 4-way stop, 2-way stop, signal, signal_with_RTOR. Note that different movements and lanes at an intersection may have different controls (e.g., a Stop Except Right Turn sign)   

Traffic signals call for several additional files:
- `signal_controller` has one record for each signal controller.  Typically, each node that represents an intersection has one signal controller, but there are cases where one signal controller might be associated with several nodes (e.g.,  two sides of a divided highway at a crossroads)
- A controller is associated with several signal phase records, with one record for each phase.  The signal phase record indicates the ring, barrier, and position (RBP) for each phase of the signal
- Each signal phase is associated with a controller and with one or more movements (for traffic movements) or links (for crosswalks) that may move on that phase.  Similarly, movements may move on more than one signal phase. These are indicated in the signal_phase_mvmt table. 
- A signal phase is associated with at least one signal timing plan.  If timing plans vary by time of day or day or week, the signal phase will be associated with multiple timing plans.  

## signal_controller

The signal controller is associated with an intersection or a cluster of intersections. 

| Field                                            | Type     | Required? | Comment                   |
| ------------------------------------------------ | -------- | --------- | ------------------------- |
| <span class="underline">controller\_id</span>          | Controller\_ID | Required  | Primary key |

## signal_phase

The following conventions are typically used for phase numbers (see figure):

  - Main street through movements are allowed on phases 2 and 6

  - Protected left turns from the main street are allowed on phases 1
    and 5

  - Side street through movements are allowed on phases 4 and 8

  - Protected left turns from the side street are allowed on phases 3
    and 7

  - Right turns are handed in one of two ways
    
      - Concurrently with the associated through movement. For example,
        if the through movement for the main street eastbound is on
        Phase 2, the right turn from the main street eastbound is also
        on Phase 2
    
      - Concurrently with the non-conflicting left turn movement from
        the side street. This is possible with dedicated right-turn
        lanes and can reduce pedestrian conflicts. In this case, the
        right turn from the main street eastbound would occur during
        Phase 3 (left turn from the side street northbound).

  - An exclusive pedestrian phase will be assigned a phase number higher
    than 8.

Finally, note that in the figure below, the phases connected by solid lines may not
operate concurrently, while phases connected by dashed lines may operate
concurrently.

![Phase numbering convention, described in the body of the text.](https://github.com/zephyr-data-specs/GMNS/raw/master/Images/signal_phase.png)  
_Phase numbering convention._ Source: MassDOT, ACST Final Plan (2014)

For signalized nodes, establishes phases that may run concurrently, using ring-barrier notation.  Each phase is associated with a ring and a barrier.  In order to run concurrently, two phases must be in:
-	the same barrier, and
-	different rings

For example, in the diagram above, the phases are associated with rings and barriers as follows:
<table>
<tr> <td>Phases</td> <th colspan="2">Barrier 1</th> <th colspan="2">Barrier 2</th> </tr>
<tr> <th>Ring 1</th> <td>2</td> <td>1</td> <td>3</td> <td>4</td> </tr>
<tr> <th>Ring 2</th> <td>5</td> <td>6</td> <td>7</td> <td>8</td> </tr>
</table>

signal_phase data dictionary

| Field                                            | Type     | Required? | Comment                   |
| ------------------------------------------------ | -------- | --------- | ------------------------- |
| <span class="underline">signal\_phase\_id</span> | Signal\_Phase\_ID | Required | Primary key |
| <span class="underline">controller\_id</span>          | Controller\_ID | Required  | Foreign key (Signal_controller table) |
| <span class="underline">signal\_phase\_num</span>     | INTEGER  | Required  | controller_id and signal_phase_num are unique              |
| <span class="underline">ring</span> | INTEGER  | Required  |                           |
| <span class="underline">barrier</span> | INTEGER  | Required  |                           |
| <span class="underline">position</span> | INTEGER  | Required  |                           |


## signal_phase_mvmt

The `signal_phase_mvmt` table associates Movements and pedestrian Links (e.g., crosswalks) with signal phases. A
signal phase may be associated with several Movements. A Movement may also run on more than one phase.

signal_phase_mvmt data dictionary

| Field                                          | Type            | Required?              | Comment                                                                                                                           |
| ---------------------------------------------- | --------------- | ---------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| signal_phase_mvmt_id | signal_phase_mvmt_id | Required | Primary key |
| <span class="underline">signal\_phase\_id</span>  | Signal\_Phase\_ID  |  Required | Foreign key  |
| <span class="underline">controller\_id</span>        | Controller\_ID        | Optional               | Redundant with field in the signal\_phase table.           |
| <span class="underline">signal\_phase\_num</span>   | INTEGER         | Optional               | Redundant with field in the signal\_phase table.    ; each phase has one or more Movements associated with it  
| <span class="underline">mvmt\_id</span>  | Movement\_ID  | Conditionally Required | Foreign key. Either Movement\_ID (for phases used by vehicles), or Link\_id (for phases used by pedestrians) is required |
| <span class="underline">link\_id</span> | Link\_ID | Conditionally Required | Foreign key                                                                                                                       |
| protection                                       | TEXT              | Optional  | Indicates whether the phase is Protected or  Permissive.                           |
| notes                                          | Text            | Optional               |                                                                                                                                   |


## signal_timing_plan

For signalized nodes, establishes timing plans and coordination.

signal_timing_plan data dictionary

| Field                                             | Type             | Required? | Comment                                                                  |
| ------------------------------------------------- | ---------------- | --------- | ------------------------------------------------------------------------ |
| <span class="underline">controller\_id</span>           | Controller\_ID         | Required  | Foreign key (signal_controller table)                                                |
| <span class="underline">timing\_plan\_id</span>   | Timing\_Plan\_ID | Required  | Primary key                                                              |
| <span class="underline">time_day</span>          | TimeDay\_Set     | Conditionally required  |  Define the availability/role of signal at different dates and times (either time_day or timeday_id is required)   |
| <span class="underline">timeday\_id</span>        | TimeDay\_ID 	| Conditionally required  | Used if times-of-day are defined on the time_set_definitions table   |
| <span class="underline">cycle\_length</span>      | INTEGER          | Optional  | Cycle length in seconds                                                  |
| <span class="underline">coord\_contr_id</span>        | Node\_ID         | Optional  | For coordinated signals, the “master” signal controller for coordination   |
| <span class="underline">coord_phase</span> | INTEGER          | Optional  | For coordinated signals, the phase at which coordination starts (time 0) |
| offset                                            | INTEGER          | Optional  | Offset in seconds                                                        |

## signal_timing_phase

For signalized nodes, provides signal timing.

signal_timing_phase data dictionary

| Field                                            | Type              | Required? | Comment                                                                                                   |
| ------------------------------------------------ | ----------------- | --------- | --------------------------------------------------------------------------------------------------------- |
| <span class="underline">timing\_phase\_id</span> | Timing\_Phase\_ID | Required  | Primary key                                                                                               |
| <span class="underline">signal\_phase\_id</span>          | Signal\_Phase\_ID          | Required  | The associated signal phase.  Foreign key                                      |
| <span class="underline">timing\_plan\_id</span>  | Timing\_Plan\_ID  | Optional  | Foreign key. If it is not provided, the timing applies all day                  |
| <span class="underline">phase\_num</span>     | INTEGER           | Optional  | Redundant with the record in the signal_phase table                               |
| <span class="underline">min\_green</span>        | INTEGER           | Required  | The minimum green time in seconds for an actuated signal. Green time in seconds for a fixed time signal   |
| <span class="underline">max\_green</span>        | INTEGER           | Optional  | The maximum green time in seconds for an actuated signal; the default is minimum green plus one extension |
| extension                                        | INTEGER           | Optional  | The number of seconds the green time is extended each time vehicles are detected                          |
| clearance                                        | INTEGER           | Required  | Yellow interval plus all red interval                                                                     |
| walk_time                                        | INTEGER           | Required  | If a pedestrian phase exists, the walk time in seconds                                                                     |
| ped_clearance                                        | INTEGER           | Required  | If a pedestrian phase exists, the flashing don’t walk time.                                                                       |

## Relationships
![Relationships with and among the Signal tables](https://github.com/zephyr-data-specs/GMNS/blob/updates/Images/SignalER2.png)
