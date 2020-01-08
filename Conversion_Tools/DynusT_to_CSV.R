# Purpose: Convert Lima network raw tables in DynusT .dat format to readable text file in CSVs.
# Authors: Volpe Center

#### Setup ####
rm(list = ls())
setwd("~/GitHub/network_data_specification/Small_Network_Examples/Lima/DynusT")

library(dplyr) # install.packages(c("dplyr","readr","data.table"))
library(data.table) # for fwrite table writing

# Check existence of sub-directory to store the intermediate CSVs and create if doesn't exist
ifelse(!dir.exists(file.path(getwd(), "Intermediate CSVs")), dir.create(file.path(getwd(), "Intermediate CSVs")), "The directory 'Intermediate CSVs' already exists")

#### Convert DynusT raw tables in .dat to table format ####
# parameters
RERUN  = F # F to use already prepared data, T to rerun the code
DynusT.tb.names <- c("xy", "network", "movement", "linkname", "linkxy")

## convert xy.dat to table format
xy.fname <- "Intermediate CSVs/xy.dat.csv"

if (!file.exists(xy.fname) & RERUN) {
  
  ## Load xy.dat
  xy <- readLines("xy.dat")
  xy.names <- c("Node", "X", "Y")
  
  xy <- read.table(text = xy, sep = "", header = FALSE, fill = TRUE, stringsAsFactors = F, col.names = xy.names)
  fwrite(xy, "Intermediate CSVs/xy.dat.csv", row.names = FALSE)
  
}


## convert network.dat to table format
network.fname <- "Intermediate CSVs/network.dat.csv"

if (!file.exists(network.fname) & RERUN) {
  
  ## Load network.dat
  network <- readLines("network.dat")
  network.names <- c("From", "To", "LTBays", "RTBays", "Length", "Lanes", "TraffFlowModel", "SpeedAdjFactor", "SpeedLimit", "MaxServiceFlow", "SaturationFlow", "LinkType", "Grade")
  
  network.temp <- read.table(text = network, sep = "", header = FALSE, fill = TRUE, stringsAsFactors = F, col.names = network.names)
  n.missing <- rowSums(is.na(network.temp))
  
  basic.data <- data.frame(network.temp[1, 1:5])
  names(basic.data) <- c("nZone", "nNodes", "nLinks", "nK_Shortest_Path", "Use_Super_Zones")
  fwrite(basic.data, "Intermediate CSVs/basic.data.csv", row.names = FALSE)
  
  nskip = min(which(n.missing == 0)) - 1
  
  node.data <- data.frame(network.temp[2:nskip, 1:2])
  names(node.data) <- c("Node", "Zone_ID")
  fwrite(node.data, "Intermediate CSVs/node.data.csv", row.names = FALSE)
  
  network <- read.table(text = network, sep = "", header = FALSE, fill = TRUE, skip = nskip, stringsAsFactors = F, col.names = network.names)
  fwrite(network, "Intermediate CSVs/network.dat.csv", row.names = FALSE)

}


## convert movement.dat to table format
movement.fname <- "Intermediate CSVs/movement.dat.csv"

if (!file.exists(movement.fname) & RERUN) {
  
  ## Load movement.dat
  movement <- readLines("movement.dat")
  movement.names <- c("From_Node", "To_Node", "LT_Node", "Thru_Node", "RT_Node", "O1_Node", "O2_Node", "U_Turn")
  
  movement <- read.table(text = movement, sep = "", header = FALSE, fill = TRUE, stringsAsFactors = F, col.names = movement.names)
  
  fwrite(movement, "Intermediate CSVs/movement.dat.csv", row.names = FALSE)

}



## convert linkname.dat to table format with link names, and save as linkname.dat.csv
linkname.fname <- "Intermediate CSVs/linkname.dat.csv"

if (!file.exists(linkname.fname) & RERUN) {
  
  ## Load linkname.dat
  linkname <- readLines("linkname.dat")
  linkname <- trimws(linkname)
  linkname <- gsub('([0-9]) ([[:alpha:]])', '\\1,\\2', linkname)
  
  linkname.names <- c("Link_ID", "Link_Name")
  linkname <- read.table(text = linkname, sep = ",", header = FALSE, fill = TRUE, stringsAsFactors = F, col.names = linkname.names)
  # linkname$Link_Name[linkname$Link_Name == ""] = "Missing" #(a street could actually be named "Missing St")
  
  # check if network link_ID match the linkname Link_ID, if all matched, save linkname in a csv, if not, display a warning message
  network$Link_ID <- paste(network$From, network$To)
  network <- network %>% left_join(linkname, by = c("Link_ID"))
  if (sum(is.na(network$linkname)) == 0) {
    cat("The network table and linkname table match")
    fwrite(linkname, "Intermediate CSVs/linkname.dat.csv", row.names = FALSE)
  } else {
    cat("Warning: The network table and linkname table do not match")}

}



## convert linkxy.dat to table format with WKT translated, and save as linkxy.dat.csv
linkxy.fname <- "Intermediate CSVs/linkxy.dat.csv"

if (!file.exists(linkxy.fname) & RERUN) {
  
  ## Load linkxy.dat
  linkxy <-  readLines("linkxy.dat")
  linkxy <- trimws(linkxy, which = "left") # remove the leading whitespace
  linkxy <- gsub("\\s+", "|", linkxy, fixed = FALSE) # replace many spaces to one space
  linkxy <- gsub(",|", " ", linkxy, fixed = TRUE)
  linkxy <- gsub(";|", ",", linkxy, fixed = TRUE)
  linkxy <- gsub(";", ",", linkxy, fixed = TRUE)
  
  linkxy.names = c("From","To", "NumMidPoints","Shape_Points")
  linkxy <- read.table(text = linkxy, sep = "|", header=FALSE, stringsAsFactors = F, col.names = linkxy.names)
  
  # WKT translation
  # linkxy <- linkxy %>% left_join(xy, by = c("From" = "Node")) %>% mutate(From_Point = paste(X, Y)) %>% dplyr::select(c(linkxy.names, "From_Point"))
  # linkxy <- linkxy %>% left_join(xy, by = c("To" = "Node")) %>% mutate(To_Points = paste(X, Y)
  #                                                                      , Shape_Points = paste0("LINESTRING(",From_Point, ",", Shape_Points, To_Points,")")) %>% dplyr::select(linkxy.names)
  fwrite(linkxy, "Intermediate CSVs/linkxy.dat.csv", row.names = FALSE)
  
}

