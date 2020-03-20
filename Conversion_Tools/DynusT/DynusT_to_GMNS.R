# Purpose: Convert Lima network in DynusT format to General Modeling Network Specification (GMNS) v0.74.
# Authors: Volpe Center

#### Setup ####
rm(list = ls())
setwd("~/GitHub/GMNS/Small_Network_Examples/Lima/DynusT") # Once the GitHub directory is mapped to your local user 'Documents' folder.
# install.packages(c("dplyr","readr","data.table"))
library(dplyr)
library(readr)
library(data.table) # for fwrite(), this function writes faster than write.csv() https://www.r-bloggers.com/fast-csv-writing-for-r/

#### Load Intermediate CSVs converted using DynusT raw data ####
## Load xy.dat.csv
xy <- read.csv("Intermediate CSVs/xy.dat.csv")

## Load linkname.dat.csv
linkname <- read.csv("Intermediate CSVs/linkname.dat.csv")

## Load network.dat.csv
network <- read.csv("Intermediate CSVs/network.dat.csv")
node.data <- read.csv("Intermediate CSVs/node.data.csv")
# adding two columns to network table
network$Link_ID <- paste(network$From, network$To)
network <- network %>% left_join(linkname, by = c("Link_ID"))

## Load movement.dat.csv
movement <- read.csv("Intermediate CSVs/movement.dat.csv")

## Load linkxy.dat.csv
linkxy <- read.csv("Intermediate CSVs/linkxy.dat.csv")
# Translate Shape_Points to WKT format
linkxy.names = c("From","To", "NumMidPoints","Shape_Points")
linkxy <- linkxy %>% left_join(xy, by = c("From" = "Node")) %>% mutate(From_Point = paste(X, Y)) %>% dplyr::select(c(linkxy.names, "From_Point"))
linkxy <- linkxy %>% left_join(xy, by = c("To" = "Node")) %>% mutate(To_Points = paste(X, Y)
                                                                     , Shape_Points = paste0("LINESTRING(",From_Point, ",", Shape_Points, To_Points,")")) %>% dplyr::select(linkxy.names)


#### Data Dictionary in DynusT ####
# This correpsond to FacilityType in GMNS
DynusTLinkType <- data.frame(LinkType = 1:10
                             , Desc = c("Freeway", "Freeway Segment with Detector (for Ramp Metering)"
                                        , "On-Ramp"
                                        , "Off-Ramp"
                                        , "Arterial"
                                        , "HOT"
                                        , "Highway"
                                        , "HOV"
                                        , "Freeway HOT"
                                        , "Freeway HOV"
                             )
)

DynusTControlType <- data.frame(ControlType = 1:6
                                , Desc = c("No control"
                                           , "Yield Sign"
                                           , "4-way stop sign"
                                           , "Pre-timed signal control"
                                           , "Actuated signal control"
                                           , "2-way stop sign"
                                )
)

#### Establish Business Rules and Convert DynusT to GMNS ####
## NODE
NODE_names <- c("node_id", "name", "x_coord", "y_coord", "z_coord", "node_type", "control_type", "zone")
NODE <- data.frame(matrix(NA, ncol = length(NODE_names), nrow = nrow(xy), dimnames = list(1:nrow(xy), NODE_names)))

xy <- xy %>% left_join(node.data, by = "Node")

NODE <- NODE %>% mutate(node_id = xy$Node
                        , x_coord = xy$X
                        , y_coord = xy$Y
                        , zone = xy$Zone_ID)


## LINK_GEOMETRY
# Business Rule:
# - if in the network table, a pair of nodes exist, then this pair will be a row in the LINK_GEOMETRY table.
# - if in the network table, a pair of nodes do not exist, then that node A to node B will be an individual row in the LINK_GEOMETRY table.

## first identify unique pairs of nodes.
ab <- data.frame(t(apply(network[,1:2], 1, sort)))  # take first two columns with od nodes, then sort them by row
colnames(ab) <- c("A_Node","B_Node")
ab <- cbind(network, ab) # create a new data with unique OD pair identified, better not modify the raw dataset.
ab <- ab %>% group_by(A_Node, B_Node) %>% summarize(Num_Pair = n()) %>% ungroup() %>% right_join(ab, by = c("A_Node","B_Node"))  # and added to the data frame.

# unique OD pair
od <- ab[,c("From","To")]
od <- od[!duplicated(t(apply(od, 1, sort))),] # update od table to unique pairs
od <- od %>% left_join(ab %>% dplyr::select("From","To", "Num_Pair", "Length", "Grade"), by = c("From","To"))

LINK_GEOMETRY_names <- c("link_geometry_id", "name", "facility_type", "grade", "geometry", "length", "row_width", "jurisdiction", "a_node", "b_node", "ab_link", "ba_link")
LINK_GEOMETRY <- data.frame(matrix(NA, ncol = length(LINK_GEOMETRY_names), nrow = nrow(od), dimnames = list(1:nrow(od), LINK_GEOMETRY_names)))

LINK_GEOMETRY <- LINK_GEOMETRY %>% mutate(link_geometry_id = 1:nrow(od)
                                          , a_node = od$From
                                          , b_node = od$To
                                          , ab_link = paste(a_node,b_node)
                                          , ba_link = ifelse(od$Num_Pair == 2, paste(od$To,od$From), NA)
                                          , length = od$Length
                                          , grade = od$Grade
)

# Looks like linkxy.dat contains only a subset of physical links. For links without mid shape point, they are not included here. The WKT of these linkes will simply be the xy coordinates of the From and To nodes.
LINK_GEOMETRY <- LINK_GEOMETRY %>% left_join(linkxy %>% dplyr::select(From, To, Shape_Points), by = c("a_node" = "From", "b_node" = "To")) %>% mutate(geometry = Shape_Points) %>% dplyr::select(LINK_GEOMETRY_names)
LINK_GEOMETRY <- LINK_GEOMETRY %>% left_join(linkxy, by = c("b_node" = "From", "a_node" = "To")) 
sum(!is.na(LINK_GEOMETRY$Geometry)) + sum(!is.na(LINK_GEOMETRY$Shape_Points)) # 767 + 583 = 1350
# check to see if there exists any missing Geometry column can be filled with Shape_Points? Only kept Geometry column, which the shape following the flow from A_Node to B_Node.
if (nrow(LINK_GEOMETRY[is.na(LINK_GEOMETRY$geometry) & !is.na(LINK_GEOMETRY$Shape_Points),]) > 0) {"Exist"} else {"Do not exist"}

# Fill in the rest of links that are missing geometry
LINK_GEOMETRY <- LINK_GEOMETRY %>% left_join(xy, by = c("a_node" = "Node")) %>% mutate(From_Point = paste(X, Y)) %>% dplyr::select(c(LINK_GEOMETRY_names, "From_Point"))
LINK_GEOMETRY <- LINK_GEOMETRY %>% left_join(xy, by = c("b_node" = "Node")) %>% mutate(To_Points = paste(X, Y),
                                                                                       Shape_Points = paste0("LINESTRING(",From_Point, ",", To_Points,")"))
LINK_GEOMETRY$geometry <- as.character(LINK_GEOMETRY$geometry)
LINK_GEOMETRY$geometry[is.na(LINK_GEOMETRY$geometry)] = LINK_GEOMETRY$Shape_Points[is.na(LINK_GEOMETRY$geometry)]
LINK_GEOMETRY <- LINK_GEOMETRY %>% dplyr::select(LINK_GEOMETRY_names)

# Add names to the link geometry table
# (takes the name of the AB_link)

LINK_GEOMETRY <- LINK_GEOMETRY %>% left_join(linkname, by = c("ab_link" = "Link_ID")) 
LINK_GEOMETRY <- LINK_GEOMETRY %>% mutate(name = Link_Name)
LINK_GEOMETRY <- LINK_GEOMETRY %>% dplyr::select(LINK_GEOMETRY_names)

# Get Link_Geometry_ID for the LINK_GEOMETRY table
network <- network %>% left_join(LINK_GEOMETRY %>% dplyr::select(link_geometry_id, a_node, b_node), by = c("From" = "a_node", "To" = "b_node"))
network <- network %>% left_join(LINK_GEOMETRY %>% dplyr::select(link_geometry_id, a_node, b_node), by = c("From" = "b_node", "To" = "a_node"))

# exist duplicated rows?
if(nrow(network[!is.na(network$link_geometry_id.x) & !is.na(network$link_geometry_id.y),]) > 0) {"Duplicates exist"} else {"No duplicates"}
sum(!is.na(network$link_geometry_id.x)) + sum(!is.na(network$link_geometry_id.y)) # 6095

# combine the two columns to get the Link_Geometry_ID in network table.
network$link_geometry_id = network$link_geometry_id.x
network$link_geometry_id[is.na(network$link_geometry_id)] = network$link_geometry_id.y[is.na(network$link_geometry_id)]

# (now we can add Facility Type to the LINK_GEOMETRY table)
network_factypes <- network %>%
  select(c("link_geometry_id", "LinkType")) %>%
  distinct(link_geometry_id, .keep_all = TRUE)

# removing intermediate columns not in the specification
LINK_GEOMETRY_names <- c("link_geometry_id", "name", "facility_type", "grade", "geometry", "length", "row_width", "jurisdiction")

LINK_GEOMETRY <- LINK_GEOMETRY %>% 
  left_join(network_factypes, by = c("link_geometry_id"="link_geometry_id")) %>%
  left_join(DynusTLinkType, by = c("LinkType"="LinkType")) %>% 
  mutate(facility_type = Desc) %>%
  dplyr::select(LINK_GEOMETRY_names)


## ROAD_LINK
ROAD_LINK_names <- c("road_link_id", "name", "from_node", "to_node", "link_geometry_id", "shapepoint_flag", "capacity", "free_speed", "speed_limit","lanes", "bike_facility", "ped_facility", "parking", "allowed_uses")
ROAD_LINK <- data.frame(matrix(NA, ncol = length(ROAD_LINK_names), nrow = nrow(network), dimnames = list(1:nrow(network), ROAD_LINK_names)))

ROAD_LINK <- ROAD_LINK %>% mutate(road_link_id = network$Link_ID
                                  , name = network$Link_Name
                                  , from_node = network$From
                                  , to_node = network$To
                                  , link_geometry_id = network$link_geometry_id
                                  , shapepoint_flag = ifelse(!is.na(network$link_geometry_id.x), 1, -1)
                                  , speed_limit = network$SpeedLimit # Suggest add SpeedLimit to road_link table.
                                  , capacity = network$SaturationFlow # Is SaturationFlow equivalent to Capacity?
                                  , length = network$Length
                                  , lanes = network$Lanes
)


## SEGMENT
# In the current example, no way to identify a location, except the LTBays and RTBays, this actually might require us to look at the network in a map or dig into DynusT manual for more information on the indicator.
# Assumptions: any bay by default 200 ft (parameter.dat), create a location based on the LTBay or RTbay. This is based on network table.
# Brian's comment: make the by default length as a global parameter. This parameter could change with road functional classes, speed limit, etc. to allow the simulation to work.

SEGMENT_names <- c("segment_id", "road_link_id", "ref_node", "start_lr", "end_lr", "capacity", "free_speed", "bike_facility", "ped_facility", "parking", "allowed_uses")
SEGMENT <- data.frame(matrix(NA, ncol = length(SEGMENT_names), nrow = nrow(network), dimnames = list(1:nrow(network), SEGMENT_names)))

pocket_length <- readLines("parameter.dat")[20] # line of parameter.dat that gets bay length
pocket_length <- parse_number(pocket_length) # extracts number from file line

SEGMENT <- SEGMENT %>% mutate(segment_id = 1:nrow(network) # Primary key
                              , road_link_id = ROAD_LINK$road_link_id
                              , ref_node = ifelse(network$LTBays != 0 | network$RTBays != 0, network$From, NA) # The From node is used as Reference Node, to match with SharedStreets.
                              , start_lr = network$Length - pocket_length # the pocket lane starts the default distance from the end of the link
                              , end_lr = network$Length # By default, pocket length ends at the to_node
                              , capacity = ROAD_LINK$capacity
                              , lanes_added_l = network$LTBays
                              , lanes_added_r = network$RTBays
                              
) %>% filter(!is.na(ref_node)) # Filtering only links with pocket lane.



## LANE
# Based on the network table
LANE_name <- c("lane_id", "road_link_id", "segment_id", "lane_number", "allowed_uses", "barrier_r", "barrier_l", "width")
LANE <- data.frame()

# first do the thru lanes
for (index in 1:max(ROAD_LINK$lanes)) {
  lanesL <- ROAD_LINK %>% filter(lanes >= index)
  df <- data.frame(NA, lanesL$road_link_id, NA, index, lanesL$allowed_uses, NA, NA, NA)
  names(df) <- LANE_name
  df <- df %>% mutate(lane_number = index)
  LANE <- rbind(LANE, df)
}

# the right-turn pocket lanes
rt_pockets <- SEGMENT %>% filter(lanes_added_r > 0) %>% 
  left_join(ROAD_LINK, by = c("road_link_id" = "road_link_id")) %>%
  dplyr::select(segment_id, road_link_id, lanes_added_r, lanes, allowed_uses.x)

for (index in 1:max(rt_pockets$lanes_added_r)) {
  lanesL <- rt_pockets %>% filter(lanes_added_r >= index)
  df <- data.frame(NA, lanesL$road_link_id, lanesL$segment_id, lanesL$lanes + index, lanesL$allowed_uses, NA, NA, NA)
  names(df) <- LANE_name
  LANE <- rbind(LANE, df)
}

# the left-turn pocket lanes
lt_pockets <- SEGMENT %>% filter(lanes_added_l > 0) %>% 
  left_join(ROAD_LINK,by = c("road_link_id" = "road_link_id")) %>%
  dplyr::select(segment_id, road_link_id, lanes_added_l, allowed_uses.x)

for (index in 1:max(lt_pockets$lanes_added_l)) {
  lanesL <- lt_pockets %>% filter(lanes_added_l >= index)
  df <- data.frame(NA, lanesL$road_link_id, lanesL$segment_id, -1 * index, lanesL$allowed_uses, NA, NA, NA)
  names(df) <- LANE_name
  LANE <- rbind(LANE, df)
}

LANE <- LANE %>% arrange(road_link_id) %>% mutate (lane_id = row_number()) 


## MOVEMENT
# MOVEMENT would need to use both DynusT's network and movement tables.
MOVEMENT_name <- c("movement_id", "node_id", "name", "ib_link", "ib_lane", "ob_link", "ob_lane", "type", "penalty", "capacity", "control")
MOVEMENT <- data.frame()

movement <- movement %>% mutate(ib_link = paste(From_Node, To_Node)) %>% mutate(U_Turn = if_else(U_Turn == 1, From_Node, U_Turn))
# U-turns can appear in both the O2_Node and the U_Turn field, we want to process the known U-Turns first
loopFrame <- data.frame(c(names(movement)[3:6], names(movement)[8], names(movement)[7]),c("Left","Thru","Right","Other1","U-Turn","Other2"))
names(loopFrame) <- c("Col","Dir")

for (index in 1:nrow(loopFrame)) {
  Col <- loopFrame[index, "Col"]
  Dir <- loopFrame[index, "Dir"]
  if (Col == "O2_Node") { #only the non-U-Turns
    movementL <- movement %>% filter(O2_Node != From_Node)
  }
  else {
    movementL <- movement
  } 
  movementL <- movementL %>% filter(movementL[[toString(Col)]] != 0) %>% mutate(ob_link = paste(!!!syms(c("To_Node",toString(Col))))) # concatenate the To_Node and Turning Node
  df <- data.frame(NA, movementL$To_Node, NA, movementL$ib_link, NA, movementL$ob_link, NA, Dir, NA, NA, NA)
  names(df) <- MOVEMENT_name
  MOVEMENT <- rbind(MOVEMENT, df)
}

MOVEMENT <- MOVEMENT %>% arrange(node_id) %>% mutate(movement_id = row_number())

# now handle inputting the lanes
# OK to use a list of lanes instead of creating new rows for each? Assuming yes

# proposed default behavior for including lanes in the MOVEMENT table:
# if pocket lanes exist, use those for left/right turns.
# otherwise, Lane 1 can be used for left turns and U-turns,
# the highest-numbered lane can be used for right turns, and all lanes can be used 
# for thru movements. Not sure what to do about "other" movements.

# minimum and maximum lanes of a link or a segment
minmax_lanes <- ROAD_LINK %>% left_join(SEGMENT, by = c("road_link_id" = "road_link_id")) %>%
  dplyr::select(road_link_id, lanes, lanes_added_l, lanes_added_r) %>% 
  mutate(minLane_IB = if_else(is.na(lanes_added_l),1,-1*lanes_added_l)) %>%
  mutate(maxLane_IB = if_else(is.na(lanes_added_r), lanes, lanes + lanes_added_r)) %>%
  mutate(minLane_OB = 1) %>%
  mutate(maxLane_OB = lanes)

MOVEMENT_joined <- MOVEMENT %>% left_join(dplyr::select(minmax_lanes, road_link_id, minLane_IB, maxLane_IB, lanes), by = c("ib_link" = "road_link_id")) %>%
  left_join(dplyr::select(minmax_lanes, road_link_id, minLane_OB, maxLane_OB), by = c("ob_link" = "road_link_id"))

MOVEMENT <- MOVEMENT_joined %>% mutate(ib_lane = ifelse(type == "U-Turn" | type == "Left", ifelse(minLane_IB<0, mapply(seq,rep(-1,nrow(MOVEMENT_joined)),minLane_IB), minLane_IB), ib_lane),
                                                  ob_lane = ifelse(type == "U-Turn" | type == "Left", minLane_OB, ob_lane), 
                                                  ib_lane = ifelse(type == "Right", ifelse(maxLane_IB > lanes, mapply(seq,lanes,maxLane_IB), maxLane_IB), ib_lane),
                                                  ob_lane = ifelse(type == "Right", maxLane_OB, ob_lane),
                                                  ib_lane = ifelse(type == "Thru", mapply(seq,rep(1,nrow(MOVEMENT_joined)),lanes), ib_lane),
                                                  ob_lane = ifelse(type == "Thru", mapply(seq,rep(1,nrow(MOVEMENT_joined)),lanes), ob_lane)) %>% dplyr::select(MOVEMENT_name)
# %>% mutate(Ib_Lane = as.character(Ib_Lane),Ob_Lane = as.character(Ob_Lane)) 

# looks like Ib_Lane and Ob_Lane are lists, which is the reason why the table cannot be saved using write.csv()
sapply(MOVEMENT, class)

#### Output the converted Datasets ####
data.loc <- "~/GitHub/GMNS/Small_Network_Examples/Lima/GMNS"
fwrite(NODE, file.path(data.loc, "node.csv"), row.names = F)
fwrite(LINK_GEOMETRY, file.path(data.loc, "link_geometry.csv"), row.names = F)
fwrite(ROAD_LINK, file.path(data.loc, "road_link.csv"), row.names = F)
fwrite(SEGMENT, file.path(data.loc, "segment.csv"), row.names = F)
fwrite(LANE, file.path(data.loc, "lane.csv"), row.names = F)
fwrite(MOVEMENT, file.path(data.loc, "movement.csv"), row.names = F)

# Some notes on fwrite()
# # write.csv won't handle the sequences in the table
# fwrite(MOVEMENT, "MOVEMENT.csv", row.names = F)
# # fwrite() vs write.csv()
# system.time(fwrite(MOVEMENT, "MOVEMENT.csv", row.names = F)) # 0.01 second
# system.time(write.csv(MOVEMENT, "MOVEMENT.csv", row.names = F)) # 0.17 seconds elapsed.



