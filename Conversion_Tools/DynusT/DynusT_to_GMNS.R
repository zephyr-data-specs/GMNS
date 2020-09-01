# Purpose: Convert Lima network in DynusT format to General Modeling Network Specification (GMNS) v0.74.
# WARNING: This script has not been updated to the latest version of GMNS.
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
NODE_names <- c("node_id", "name", "x_coord", "y_coord", "z_coord", "node_type", "ctrl_type", "zone_id", "parent_node_id")
NODE <- data.frame(matrix(NA, ncol = length(NODE_names), nrow = nrow(xy), dimnames = list(1:nrow(xy), NODE_names)))

xy <- xy %>% left_join(node.data, by = "Node")

NODE <- NODE %>% mutate(node_id = xy$Node
                        , x_coord = xy$X
                        , y_coord = xy$Y
                        , zone_id = xy$Zone_ID)


## GEOMETRY
# Business Rule:
# - if in the network table, a pair of nodes exist, then this pair will be a row in the GEOMETRY table.
# - if in the network table, a pair of nodes do not exist, then that node A to node B will be an individual row in the GEOMETRY table.

## first identify unique pairs of nodes.
ab <- data.frame(t(apply(network[,1:2], 1, sort)))  # take first two columns with od nodes, then sort them by row
colnames(ab) <- c("A_Node","B_Node")
ab <- cbind(network, ab) # create a new data with unique OD pair identified, better not modify the raw dataset.
ab <- ab %>% group_by(A_Node, B_Node) %>% summarize(Num_Pair = n()) %>% ungroup() %>% right_join(ab, by = c("A_Node","B_Node"))  # and added to the data frame.

# unique OD pair
od <- ab[,c("From","To")]
od <- od[!duplicated(t(apply(od, 1, sort))),] # update od table to unique pairs
od <- od %>% left_join(ab %>% dplyr::select("From","To", "Num_Pair", "Length", "Grade"), by = c("From","To"))

GEOMETRY_names <- c("geometry_id", "name", "geometry", "length", "row_width", "jurisdiction", "a_node", "b_node", "ab_link", "ba_link")
GEOMETRY <- data.frame(matrix(NA, ncol = length(GEOMETRY_names), nrow = nrow(od), dimnames = list(1:nrow(od), GEOMETRY_names)))

GEOMETRY <- GEOMETRY %>% mutate(geometry_id = 1:nrow(od)
                                          , a_node = od$From
                                          , b_node = od$To
                                          , ab_link = paste(a_node,b_node)
                                          , ba_link = ifelse(od$Num_Pair == 2, paste(od$To,od$From), NA)
                                          , length = od$Length
                                          , grade = od$Grade
)

# Looks like linkxy.dat contains only a subset of physical links. For links without mid shape point, they are not included here. The WKT of these linkes will simply be the xy coordinates of the From and To nodes.
GEOMETRY <- GEOMETRY %>% left_join(linkxy %>% dplyr::select(From, To, Shape_Points), by = c("a_node" = "From", "b_node" = "To")) %>% mutate(geometry = Shape_Points) %>% dplyr::select(GEOMETRY_names)
GEOMETRY <- GEOMETRY %>% left_join(linkxy, by = c("b_node" = "From", "a_node" = "To")) 
sum(!is.na(GEOMETRY$Geometry)) + sum(!is.na(GEOMETRY$Shape_Points)) # 767 + 583 = 1350
# check to see if there exists any missing Geometry column can be filled with Shape_Points? Only kept Geometry column, which the shape following the flow from A_Node to B_Node.
if (nrow(GEOMETRY[is.na(GEOMETRY$geometry) & !is.na(GEOMETRY$Shape_Points),]) > 0) {"Exist"} else {"Do not exist"}

# Fill in the rest of links that are missing geometry
GEOMETRY <- GEOMETRY %>% left_join(xy, by = c("a_node" = "Node")) %>% mutate(From_Point = paste(X, Y)) %>% dplyr::select(c(GEOMETRY_names, "From_Point"))
GEOMETRY <- GEOMETRY %>% left_join(xy, by = c("b_node" = "Node")) %>% mutate(To_Points = paste(X, Y),
                                                                                       Shape_Points = paste0("LINESTRING(",From_Point, ",", To_Points,")"))
GEOMETRY$geometry <- as.character(GEOMETRY$geometry)
GEOMETRY$geometry[is.na(GEOMETRY$geometry)] = GEOMETRY$Shape_Points[is.na(GEOMETRY$geometry)]

GEOMETRY_names <- c("geometry_id", "name", "geometry", "length", "row_width", "jurisdiction", "a_node", "b_node", "ab_link", "ba_link")
GEOMETRY <- GEOMETRY %>% dplyr::select(GEOMETRY_names)

# Add names to the link geometry table
# (takes the name of the AB_link)

GEOMETRY <- GEOMETRY %>% left_join(linkname, by = c("ab_link" = "Link_ID")) 
GEOMETRY <- GEOMETRY %>% mutate(name = Link_Name)
GEOMETRY <- GEOMETRY %>% dplyr::select(GEOMETRY_names)

# Get Link_Geometry_ID for the GEOMETRY table
network <- network %>% left_join(GEOMETRY %>% dplyr::select(geometry_id, a_node, b_node), by = c("From" = "a_node", "To" = "b_node"))
network <- network %>% left_join(GEOMETRY %>% dplyr::select(geometry_id, a_node, b_node), by = c("From" = "b_node", "To" = "a_node"))

# exist duplicated rows?
if(nrow(network[!is.na(network$geometry_id.x) & !is.na(network$geometry_id.y),]) > 0) {"Duplicates exist"} else {"No duplicates"}
sum(!is.na(network$geometry_id.x)) + sum(!is.na(network$geometry_id.y)) # 6095

# combine the two columns to get the Link_Geometry_ID in network table.
network$geometry_id = network$geometry_id.x
network$geometry_id[is.na(network$geometry_id)] = network$geometry_id.y[is.na(network$geometry_id)]

# (now we can add Facility Type to the GEOMETRY table)
network_factypes <- network %>%
  select(c("geometry_id", "LinkType")) %>%
  distinct(geometry_id, .keep_all = TRUE)

# removing intermediate columns not in the specification
GEOMETRY_names <- c("geometry_id", "name", "geometry", "length", "row_width", "jurisdiction")

GEOMETRY <- GEOMETRY %>% dplyr::select(GEOMETRY_names)


## LINK
LINK_names <- c("link_id", "name", "from_node_id", "to_node_id", "directed", "geometry_id", "geometry", "parent_link_id", "dir_flag", "length", "grade", "facility_type","capacity", "free_speed","lanes", "bike_facility", "ped_facility", "parking", "allowed_uses", "toll", "jurisdiction", "row_width")
LINK <- data.frame(matrix(NA, ncol = length(LINK_names), nrow = nrow(network), dimnames = list(1:nrow(network), LINK_names)))

LINK <- LINK %>% mutate(link_id = network$Link_ID
                                  , name = network$Link_Name
                                  , from_node_id = network$From
                                  , to_node_id = network$To
                                  , geometry_id = network$geometry_id
                                  , dir_flag = ifelse(!is.na(network$geometry_id.x), 1, -1)
                                  , free_speed = network$SpeedLimit 
                                  , capacity = network$SaturationFlow # Is SaturationFlow equivalent to Capacity?
                                  , length = network$Length
                                  , lanes = network$Lanes
                                  , length = network$Length
                                  , grade = network$Grade
) %>% left_join(network_factypes, by = c("geometry_id"="geometry_id")) %>%
  left_join(DynusTLinkType, by = c("LinkType"="LinkType")) %>% 
  mutate(facility_type = Desc) %>% 
  select(LINK_names)

LINK <- LINK %>% mutate(facility_type = tolower(facility_type))

## SEGMENT
# In the current example, no way to identify a location, except the LTBays and RTBays, this actually might require us to look at the network in a map or dig into DynusT manual for more information on the indicator.
# Assumptions: any bay by default 200 ft (parameter.dat), create a location based on the LTBay or RTbay. This is based on network table.
# Brian's comment: make the by default length as a global parameter. This parameter could change with road functional classes, speed limit, etc. to allow the simulation to work.

SEGMENT_names <- c("segment_id", "link_id", "ref_node_id", "start_lr", "end_lr", "grade", "capacity", "free_speed", "lanes", "l_lanes_added", "r_lanes_added", "bike_facility", "ped_facility", "parking", "allowed_uses", "toll", "jurisdiction", "row_width")
SEGMENT <- data.frame(matrix(NA, ncol = length(SEGMENT_names), nrow = nrow(network), dimnames = list(1:nrow(network), SEGMENT_names)))

pocket_length <- readLines("parameter.dat")[20] # line of parameter.dat that gets bay length
pocket_length <- parse_number(pocket_length) # extracts number from file line

SEGMENT <- SEGMENT %>% mutate(segment_id = 1:nrow(network) # Primary key
                              , link_id = LINK$link_id
                              , ref_node_id = ifelse(network$LTBays != 0 | network$RTBays != 0, network$From, NA) # The From node is used as Reference Node, to match with SharedStreets.
                              , start_lr = network$Length - pocket_length # the pocket lane starts the default distance from the end of the link
                              , end_lr = network$Length # By default, pocket length ends at the to_node
                              , capacity = LINK$capacity
                              , l_lanes_added = network$LTBays
                              , r_lanes_added = network$RTBays
                              , grade = network$Grade
                              , lanes = network$Lanes + network$LTBays + network$RTBays
                              
) %>% filter(!is.na(ref_node_id)) # Filtering only links with pocket lane.



## LANE
# Based on the network table
LANE_name <- c("lane_id", "link_id", "lane_num", "allowed_uses", "r_barrier", "l_barrier", "width")
LANE <- data.frame()

# thru lanes only on the lane table; pocket lanes go on segment_lane table
for (index in 1:max(LINK$lanes)) {
  lanesL <- LINK %>% filter(lanes >= index)
  df <- data.frame(NA, lanesL$link_id, index, lanesL$allowed_uses, NA, NA, NA)
  names(df) <- LANE_name
  df <- df %>% mutate(lane_num = index)
  LANE <- rbind(LANE, df)
}


# segment_lane table
# all are added lanes; no parents needed
SEGMENT_LANE_name <- c("segment_lane_id", "segment_id", "lane_num", "parent_lane_id", "allowed_uses", "r_barrier", "l_barrier", "width")
SEGMENT_LANE <- data.frame()

# the right-turn pocket lanes
rt_pockets <- SEGMENT %>% filter(r_lanes_added > 0) %>% 
  left_join(LINK, by = c("link_id" = "link_id")) %>%
  dplyr::select(segment_id, link_id, r_lanes_added, lanes.x, allowed_uses.x) %>%
  rename(lanes = lanes.x)

for (index in 1:max(rt_pockets$r_lanes_added)) {
  lanesL <- rt_pockets %>% filter(r_lanes_added >= index)
  df <- data.frame(NA, lanesL$segment_id, lanesL$lanes + index, NA, lanesL$allowed_uses, NA, NA, NA)
  names(df) <- SEGMENT_LANE_name
  SEGMENT_LANE <- rbind(SEGMENT_LANE, df)
}

# the left-turn pocket lanes
lt_pockets <- SEGMENT %>% filter(l_lanes_added > 0) %>% 
  left_join(LINK,by = c("link_id" = "link_id")) %>%
  dplyr::select(segment_id, link_id, l_lanes_added, allowed_uses.x)

for (index in 1:max(lt_pockets$l_lanes_added)) {
  lanesL <- lt_pockets %>% filter(l_lanes_added >= index)
  df <- data.frame(NA, lanesL$segment_id, -1 * index, NA, lanesL$allowed_uses, NA, NA, NA)
  names(df) <- SEGMENT_LANE_name
  SEGMENT_LANE <- rbind(SEGMENT_LANE, df)
}

LANE <- LANE %>% arrange(link_id) %>% mutate (lane_id = row_number()) 
SEGMENT_LANE <- SEGMENT_LANE %>% arrange(segment_id) %>% mutate (segment_lane_id = nrow(LANE)+row_number()) 


## MOVEMENT
# MOVEMENT needs to use both DynusT's network and movement tables.
MOVEMENT_name <- c("mvmt_id", "node_id", "name", "ib_link_id", "start_ib_lane", "end_ib_lane", "ob_link_id", "start_ob_lane", "end_ob_lane","type", "penalty", "capacity", "ctrl_type")
MOVEMENT <- data.frame()

movement <- movement %>% mutate(ib_link_id = paste(From_Node, To_Node)) %>% mutate(U_Turn = if_else(U_Turn == 1, From_Node, U_Turn))
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
  movementL <- movementL %>% filter(movementL[[toString(Col)]] != 0) %>% mutate(ob_link_id = paste(!!!syms(c("To_Node",toString(Col))))) # concatenate the To_Node and Turning Node
  df <- data.frame(NA, movementL$To_Node, NA, movementL$ib_link_id, NA, NA, movementL$ob_link_id, NA, NA, Dir, NA, NA, NA)
  names(df) <- MOVEMENT_name
  MOVEMENT <- rbind(MOVEMENT, df)
}

MOVEMENT <- MOVEMENT %>% arrange(node_id) %>% mutate(mvmt_id = row_number())

# now handle inputting the lanes
# OK to use a list of lanes instead of creating new rows for each? Assuming yes

# proposed default behavior for including lanes in the MOVEMENT table:
# if pocket lanes exist, use those for left/right turns.
# otherwise, Lane 1 can be used for left turns and U-turns,
# the highest-numbered lane can be used for right turns, and all lanes can be used 
# for thru movements. Not sure what to do about "other" movements.

# minimum and maximum lanes of a link or a segment
minmax_lanes <- LINK %>% left_join(SEGMENT, by = c("link_id" = "link_id")) %>%
  dplyr::select(link_id, lanes.x, l_lanes_added, r_lanes_added) %>%
  rename(lanes = lanes.x) %>%
  mutate(minLane_IB = if_else(is.na(l_lanes_added),1,-1*l_lanes_added)) %>%
  mutate(maxLane_IB = if_else(is.na(r_lanes_added), lanes, lanes + r_lanes_added)) %>%
  mutate(minLane_OB = 1) %>%
  mutate(maxLane_OB = lanes)

MOVEMENT_joined <- MOVEMENT %>% left_join(dplyr::select(minmax_lanes, link_id, minLane_IB, maxLane_IB, lanes), by = c("ib_link_id" = "link_id")) %>%
  left_join(dplyr::select(minmax_lanes, link_id, minLane_OB, maxLane_OB), by = c("ob_link_id" = "link_id"))

# MOVEMENT <- MOVEMENT_joined %>% mutate(ib_lane = ifelse(type == "U-Turn" | type == "Left", ifelse(minLane_IB<0, mapply(seq,rep(-1,nrow(MOVEMENT_joined)),minLane_IB), minLane_IB), ib_lane),
#                                                   ob_lane = ifelse(type == "U-Turn" | type == "Left", minLane_OB, ob_lane), 
#                                                   ib_lane = ifelse(type == "Right", ifelse(maxLane_IB > lanes, mapply(seq,lanes,maxLane_IB), maxLane_IB), ib_lane),
#                                                   ob_lane = ifelse(type == "Right", maxLane_OB, ob_lane),
#                                                   ib_lane = ifelse(type == "Thru", mapply(seq,rep(1,nrow(MOVEMENT_joined)),lanes), ib_lane),
#                                                   ob_lane = ifelse(type == "Thru", mapply(seq,rep(1,nrow(MOVEMENT_joined)),lanes), ob_lane)) %>% dplyr::select(MOVEMENT_name)
# # %>% mutate(Ib_Lane = as.character(Ib_Lane),Ob_Lane = as.character(Ob_Lane)) 

MOVEMENT <- MOVEMENT_joined %>% mutate(start_ib_lane = ifelse(type == "U-Turn" | type == "Left", minLane_IB, start_ib_lane),
                                       end_ib_lane =   ifelse(type == "U-Turn" | type == "Left", ifelse(minLane_IB<0, -1, minLane_IB), end_ib_lane),
                                       start_ob_lane = ifelse(type == "U-Turn" | type == "Left", minLane_OB, start_ob_lane),
                                       end_ob_lane =   ifelse(type == "U-Turn" | type == "Left", minLane_OB, end_ob_lane),
                                       start_ib_lane = ifelse(type == "Right",ifelse(maxLane_IB > lanes, lanes+1,lanes), start_ib_lane),
                                       end_ib_lane =   ifelse(type == "Right", maxLane_IB, end_ib_lane),
                                       start_ob_lane = ifelse(type == "Right", maxLane_OB, start_ob_lane),
                                       end_ob_lane =   ifelse(type == "Right", maxLane_OB, end_ob_lane),
                                       start_ib_lane = ifelse(type == "Thru", 1, start_ib_lane),
                                       end_ib_lane =   ifelse(type == "Thru", lanes, end_ib_lane),
                                       start_ob_lane = ifelse(type == "Thru", 1, start_ob_lane),
                                       end_ob_lane =   ifelse(type == "Thru", maxLane_OB, end_ob_lane)
                                       ) %>% dplyr::select(MOVEMENT_name)

MOVEMENT <- MOVEMENT %>% mutate(type = tolower(type))

# looks like Ib_Lane and Ob_Lane are lists, which is the reason why the table cannot be saved using write.csv()
# sapply(MOVEMENT, class)

# new geometry table is smaller (didn't change earlier because script relies on old fields)
GEOMETRY_names <- c("geometry_id", "geometry")
GEOMETRY <- GEOMETRY %>% dplyr::select(GEOMETRY_names)

#### Output the converted Datasets ####
data.loc <- "~/GitHub/GMNS/Small_Network_Examples/Lima/GMNS"
fwrite(NODE, file.path(data.loc, "node.csv"), row.names = F)
fwrite(GEOMETRY, file.path(data.loc, "geometry.csv"), row.names = F)
fwrite(LINK, file.path(data.loc, "link.csv"), row.names = F)
fwrite(SEGMENT, file.path(data.loc, "segment.csv"), row.names = F)
fwrite(LANE, file.path(data.loc, "lane.csv"), row.names = F)
fwrite(SEGMENT_LANE, file.path(data.loc, "segment_lane.csv"), row.names = F)
fwrite(MOVEMENT, file.path(data.loc, "movement.csv"), row.names = F)


# Some notes on fwrite()
# # write.csv won't handle the sequences in the table
# fwrite(MOVEMENT, "MOVEMENT.csv", row.names = F)
# # fwrite() vs write.csv()
# system.time(fwrite(MOVEMENT, "MOVEMENT.csv", row.names = F)) # 0.01 second
# system.time(write.csv(MOVEMENT, "MOVEMENT.csv", row.names = F)) # 0.17 seconds elapsed.



