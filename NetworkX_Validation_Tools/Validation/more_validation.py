# GMNS Validation Tool: Basic File Structure Validation

# Inputs: Nodes, Links, Lanes, Movements, Segments from a GMNS formatted network
# Portions of the script do use optional fields, as listed below:
## Link_Geometry: length
## Road_Link: lanes
## Lanes: allowed_uses

# Outputs (printed to the screen):
# (1) a list of links that fall below the user-set minimum length
# (2) a list of links where the AB_NumberOfLanes or BA_NumberOfLanes in the table does not match the number of automotive travel lanes present in that direction in the lanes table
# (3) a list of movements where the inbound or outbound link&lane specified in the movements table do not exist in the links or lanes table
# (4) a list of required fields that are missing in each table, and a list of records in each table that have data missing from required fields

import numpy as np
import pandas as pd

# importing the GNMS node and link files
df_nodes = pd.read_csv('camb_080_node.csv',index_col='node_id') # Replace with the path to your node file
df_edges = pd.read_csv('camb_080_road_link.csv',index_col='road_link_id') # Replace with the path to your road_link file
df_link_geom = pd.read_csv('camb_080_link_geometry.csv',index_col='link_geometry_id') # Replace with the path to your link_geometry file
df_lanes = pd.read_csv('camb_080_lane.csv',index_col='lane_id') # Replace with the path to your lane file
df_mvts = pd.read_csv('camb_080_movement.csv',index_col='movement_id') # Replace with the path to your movement file
df_segs  = pd.read_csv('camb_080_segment.csv', index_col='segment_id') # Replace with the path to your segment file
df_nodes['node_id'] = df_nodes.index
df_edges['road_link_id'] = df_edges.index
df_link_geom['link_geometry_id'] = df_link_geom.index
df_lanes['lane_id'] = df_lanes.index
df_mvts['movement_id'] = df_mvts.index
df_segs['segment_id'] = df_segs.index

### rounding the XY and WKT to the same # of decimal places
### (for WGS84, 5 decimal places is ~1 meter precision)
### (not currently used in this code, but kept just in case)
##df_nodes['Xcoord'] = [round(n, 5) for n in df_nodes['Xcoord']]
##df_nodes['Ycoord'] = [round(n, 5) for n in df_nodes['Ycoord']]
##for [index,wkt] in df_edges[['Link_ID','WKT']].values:
##    coordList = [round(float(s),5) for s in wkt.replace('(', ' ').replace(')', ' ').replace(',',' ').split() if s != 'LINESTRING']
##    newWkt = 'LINESTRING ('
##    counter = 0
##    for coord in coordList:
##        if counter % 2 == 0:
##            newWkt += (str(coord) + ' ')
##        else:
##            newWkt += (str(coord) + ',')
##        counter += 1
##    newWkt += ')'
##    df_edges.loc[index,'WKT'] = newWkt
        
# checking min_length of an edge
# (user will have to verify the results of this with their specific network)
min_length = 10 # reasonableness of this value depends on units and network -- user should adjust.
too_short = df_link_geom[df_link_geom['length'] < min_length] # can also change to > to check max length
if len(too_short) > 0:
    print("The following link geometries are too short in length:")
    for edge in too_short.index:
        print("link_geometry_id #", edge)

## checking that the number of lanes in the links table is correct
# If errors exist, the NumberOfLanes, or the Lanes table, should be corrected before using this network
for [linkID,numLanes,a,b] in df_edges[['road_link_id','lanes','from_node','to_node']].values:
    linkLanes = df_lanes[df_lanes['road_link_id']==linkID]
    lanes_actual = 0
    for [modes, segment] in linkLanes[['allowed_uses', 'segment_id']].values:
        if modes in ['ALL','AUTO'] and pd.isnull(segment):
            lanes_actual += 1
    if np.nan_to_num(numLanes) != lanes_actual:
        print('Check number of lanes for road_link ' + str(linkID))

## checking that the lanes exist for all movements in the movements table
# If errors exist, the movements table or the Lanes table should be corrected before using this network
for [mvtID, node,ibLinkID,ibLaneNo,obLinkID,obLaneNo] in df_mvts[['movement_id', 'node_id', 'ib_link', 'ib_lane', 'ob_link', 'ob_lane']].values:
    # first check the lane information associated with the IB link/lane pair exists
    try:
        if df_edges[df_edges['road_link_id'] == ibLinkID].iloc[0]["to_node"] != node:
            raise ValueError
        ibLane = df_lanes[(df_lanes['road_link_id'] == ibLinkID) &
                           # (df_lanes['to_node'] == node) &
                           (df_lanes['lane_number'] == ibLaneNo)]

        # creates an array of matching lane IDs,
        # only one should have that linkID/direction/laneNo combo, so that is the one we pick
        # (if not, print a warning)
        if len(ibLane.index.values) > 1:
            print("Warning: there are multiple lanes on " + str(ibLinkID) + " going toward node "
            + str(node) + " with lane number " + str(ibLaneNo))
            ibLane = ibLane.iloc[0]
    except:
        print("Lane " + str(ibLaneNo) + " does not exist in the inbound direction for link " + str(ibLinkID)
              + " at node " + str(node) + ' but a movement for it exists, ID#' + str(mvtID))
        continue

    # now for the OB link/lane pairs
    try:
        if (df_edges[df_edges['road_link_id'] == obLinkID].iloc[0]["from_node"] != node):
            raise ValueError
        obLane = df_lanes[(df_lanes['road_link_id'] == obLinkID) &
                           # (df_lanes['To_Node'] != node) &
                           (df_lanes['lane_number'] == obLaneNo)]

        # creates an array of matching lane IDs,
        # only one should have that linkID/direction/laneNo combo, so that is the one we pick
        # (if not, print a warning)
        if len(obLane.index.values) > 1:
            print("Warning: there are multiple lanes on " + str(obLinkID) + " going away from node "
            + str(node) + " with lane number " + str(obLaneNo))
            obLane = obLane.iloc[0]
    except:
        print("Lane " + str(obLaneNo) + " does not exist in the outbound direction for link " + str(obLinkID)
              + " at node " + str(node) + ' but a movement for it exists, ID#' + str(mvtID))
        continue

    # print("movement ID#" + str(mvtID) + " has existing inbound and outbound lanes")
        

# verifying that all required fields exist and have entries

# required fields for Nodes
# user may add additional required fields as modeling purposes require
fields = ['node_id','x_coord','y_coord'] 
for field in fields:
    try:
        if df_nodes[field].isnull().any():
            print("Missing info in required node field:", field, ", node_ids:", df_nodes[df_nodes[field].isnull()].index.values)
    except KeyError:
        print("Missing required node field:", field)

# required for Road_Links
fields = ['road_link_id', 'from_node', 'to_node']
for field in fields:
    try:
        if df_edges[field].isnull().any():
            print("Missing info in required road_link field:", field, ", link_ids:", df_edges[df_edges[field].isnull()].index.values)
    except KeyError:
        print("Missing required road_link field:", field)
        
# required for Link_Geometry:
fields = ['link_geometry_id']
for field in fields:
    try:
        if df_link_geom[field].isnull().any():
            print("Missing info in required link_geometry field:", field, ", link_geometry_ids:", df_link_geom[df_link_geom[field].isnull()].index.values)
    except KeyError:
        print("Missing required link_geometry field:", field)

# required for Segments
fields = ['segment_id', 'road_link_id', 'ref_node', 'start_lr', 'end_lr']
for field in fields:
    try:
        if df_segs[field].isnull().any():
            print("Missing info in required segment field:", field, ", segment_ids:", df_segs[df_segs[field].isnull()].index.values)
    except KeyError:
        print("Missing required segment field:", field)

# required for Lanes
# Note: still need to handle checking either the presence (Link_ID + To_Node) or (Segment_ID), as outlined in the spec
fields = ['lane_id', 'road_link_id', 'segment_id', 'lane_number', 'allowed_uses']
for field in fields:
    try:
        if df_lanes[field].isnull().any():
            print("Missing info in required lane field:", field, ", lane_ids:", df_lanes[df_lanes[field].isnull()].index.values)
    except KeyError:
        print("Missing required lane field:", field)

# required for Movements
fields = ['movement_id', 'node_id', 'ib_link', 'ib_lane', 'ob_link', 'ob_lane', 'type', 'control']
for field in fields:
    try:
        if df_mvts[field].isnull().any():
            print("Missing info in required movement field:", field, ", movement_ids:", df_mvts[df_mvts[field].isnull()].index.values)
    except KeyError:
        print("Missing required movement field:", field)


# segments: overlapping segments are only allowed if one is contained in the other
# group segments by link
for link,fromNode,toNode in df_edges[['road_link_id','from_node','to_node']].values:
    
    if (df_segs[df_segs['road_link_id'] == link]['ref_node'] != fromNode).any():
        print("At least one segment on ", link, " is referenced using the to_node instead of the from_node. Correct this before proceeding.")
        continue
    segs = df_segs[df_segs['road_link_id'] == link][['segment_id', 'ref_node', 'start_lr', 'end_lr']].values.tolist()

    for i in segs:
        checkList = segs
        checkList.remove(i)
        for j in checkList:
            # is i subset of j?
            if (i[2] <= j[2]) and (i[3] >= j[3]):
                continue
            # is j subset of i?
            if (i[2] >= j[2]) and (i[3] <= j[3]):
                continue
            # do they not intersect (except for endpoints)?
            if (i[2] >= j[3]) or (i[3] <= j[2]):
                continue
            # if not, they overlap and we have an issue
            print("Segments with IDs: ", str(i[0]), " and ", str(j[0]), " overlap, but one isn't contained in the other.")
