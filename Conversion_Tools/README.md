# Conversion Tools
Basic conversion tools are available to get GMNS-formatted tables from the following sources:
- A network in [DynusT](https://www.dynust.com) format
- A network pulled from [OpenStreetMap](https://www.openstreetmap.org) using the [osmnx](https://github.com/gboeing/osmnx) python package. 

## [DynusT](DynusT/DynusT_to_GMNS.R)    
### Requirements and Inputs  
- [R](https://www.r-project.org) and a few packages: `dplyr`, `readr`, and `data.table`, all available using the `install.packages()` function.
- The following DynusT input files:
	- linkname.dat
	- linkxy.dat
	- movement.dat
	- network.dat
	- parameter.dat
	- xy.dat
	
### Outputs and Limitations  
The following GMNS-formatted tables are output by the script:
- node.csv
- geometry.csv
- link.csv
- segment.csv
- lane.csv
- segment_lane.csv
- movement.csv
 
 The script performs two main tasks: first, it converts the DynusT input files into CSV tables, and then manipulates those tables into GMNS format. The first task (converting to tables) was also separated into a stand-alone script called [DynusT_to_CSV.R](DynusT/DynusT_to_CSV.R).
 
 Note the following limitations observed while testing the conversion:
 - DynusT allows a single default length for pocket lanes to be specified for the entire network. However, links may exist in a dataset where pocket lanes were present but the length of the link was less than the specified pocket-lane length. The result is a segment where the `start_distance` is negative.
 - The movement.dat file does not include detail at the lane level about which turning movements are allowed at each lane, so the following behavior was assumed when filling in the lane fields in the MOVEMENT table:
	- Thru movements: Inbound -- all non-pocket lanes; outbound -- all non-pocket lanes.
	- Left- or U-turn movements: Inbound -- any lefthand pocket lanes, or the leftmost lane if no pocket lanes present; outbound -- leftmost lane.
	- Right-turn movements: Inbound -- any right-hand pocket lanes, or the rightmost lane if no pocket lanes present; outbound -- rightmost lane. 

    An alternative (less precise, but perhaps more accurate) option would be to exclude lane information from the movement table (leave the `start_ib_lane`, `end_ib_lane`, `start_ob_lane` and `end_ob_lane` fields blank).
 
### Example  
This script was tested on the Lima network provided with DynusT. [Inputs](../Small_Network_Examples/Lima/DynusT) and [outputs](../Small_Network_Examples/Lima/GMNS) are in the Small_Network_Examples subfolder.


## [OpenStreetMap](OSM/osm_to_gmns.py)  

This script takes a location from which to pull a network from OpenStreetMap, cleans it by consolidating nodes close to one another, and creates basic GMNS tables from the network. 

### Requirements and Inputs  
- [Python](https://www.python.org/downloads/)
- Ensure several packages are installed: `numpy, pandas, osmnx, geopandas, shapely`. The [osmnx](https://github.com/gboeing/osmnx) package is used to extract and clean the data, and the others are dependencies or used for data manipulation.
- A location for which to get street data (replace `'Cambridge, MA'` on line 35 with your desired location).
- The number of meters you want to buffer to combine nodes near one another (replace the value on line 43 with your desired buffer; this may require trial-and-error and visual inspection of your outputs until you have acceptable accuracy).

### Outputs and Limitations  
The script outputs the following GMNS-formatted tables: 
- node.csv
- geometry.csv
- link.csv

Generating segment tables may be possible by setting `simplify = False` in the osmnx `graph_from_place()` function, but further exploration is required. Other tables may require more assumptions or another extraction tool to create -- for example, [osmnx does not extract turn restrictions](https://github.com/gboeing/osmnx/issues/22).

### Example  
This script was tested with input parameters `'Cambridge, MA'` as the location and `10` meters as the tolerance. Output files are located in the [OSM subfolder](OSM). Due to continual edits to OpenStreetMap, running this script may not result in identical output files to those located here.
