# -*- coding: utf-8 -*-
"""
OpenStreetMap to GMNS [Work In Progress]

A script that inputs a location from which to pull a network from OpenStreetMap,
and then converts it to basic GMNS format. 

Completed: 
- Using the osmnx package to pull a network from OSM and clean it
    (using modified osmnx.simplify.clean_intersections function)
- Node, link_geometry, road_link tables are complete in GMNS format

Not done:
- Segments would need to be generated using OSM data using the simplify = False 
    setting in graph_from_place. Current behavior when a road changes attributes in the 
    middle of a link is that all values are given in an array (e.g., lanes = ['2', '3']).
    As an aside, this doesn't cooperate well with exporting to a shapefile.
- Lanes depend on developing the segments table.
- Turn restrictions are not available via osmnx, so a movements table wouldn't add much value
    (esp. since lane-level detail on turning movements isn't available either). 

Pulling the network from OSM and cleaning it (removing excess nodes) are done
using the osmnx package. 
"""

import numpy as np
import pandas as pd
import osmnx as ox
from geopandas import gpd
from shapely.geometry import Polygon

G_up = ox.graph_from_place('Cambridge, MA', network_type='drive')
# project_graph converts from WGS84 lat-long to the appropriate UTM zone
# (so distance calculations will use meters instead of degrees)
G = ox.project_graph(G_up)
#save_graph_shapefile(G) # saves edge and node shps, for link_geometry

# parameter for osmnx's clean_intersections function
# (default is 15)
tolerance=10 # this must be checked for reasonableness with the network at hand
#e.g., with Cambridge, I decreased this to 10, which isn't perfect, but better than 15


# This section of the code is the osmnx.simplify.clean_intersections function
# (copied from https://github.com/gboeing/osmnx/blob/master/osmnx/simplify.py)
# using the source code directly to access the local variables he uses  

# (here there was a section of code if you want to remove external nodes, but we want to keep them)

# create a GeoDataFrame of nodes, buffer to passed-in distance, merge
# overlaps
gdf_nodes = ox.graph_to_gdfs(G, edges=False)
buffered_nodes = gdf_nodes.buffer(tolerance).unary_union
if isinstance(buffered_nodes, Polygon):
    # if only a single node results, make it iterable so we can turn it into
    # a GeoSeries
    buffered_nodes = [buffered_nodes]

# get the centroids of the merged intersection polygons
unified_intersections = gpd.GeoSeries(list(buffered_nodes))
intersection_centroids = unified_intersections.centroid
# return intersection_centroids # (end of osmnx.simplify.clean_intersections function)

# name the series
intersection_centroids.name = "centroid"

# joining the nodes to their buffers
gdf_buffers = gpd.GeoDataFrame(intersection_centroids, geometry = unified_intersections)
gdf_buffers.crs = gdf_nodes.crs # for some reason the coordinate system gets lost
gdf_nodes_joined = gpd.sjoin(gdf_nodes,gdf_buffers, how="left", op="within")
# change the geometry of the nodes to the centroids
gdf_nodes_joined = gdf_nodes_joined.set_geometry("centroid")
gdf_nodes_joined = gdf_nodes_joined.drop(columns = ["geometry"])
# gdf_nodes_joined.to_file(filename="test.shp") # export the merged nodes as a shapefile
# (to verify a reasonable tolerance value is selected)

# now update the node ids on the edges 
gdf_edges = ox.graph_to_gdfs(G, nodes=False)
# on the edges table: the to_node column is called "u"; the from_node column is "v"
# on the nodes table: old node_id is "osmid"; new node_id is "index_right"

# first join wrt the to_nodes
gdf_edges_joined = gdf_edges.merge(gdf_nodes_joined,left_on="u",right_on="osmid")
gdf_edges_joined["u"] = gdf_edges_joined["index_right"]
# now wrt the from_nodes
gdf_edges_joined = gdf_edges_joined.merge(gdf_nodes_joined,left_on="v",right_on="osmid")
gdf_edges_joined["v"] = gdf_edges_joined["index_right_y"]

# remove extra columns and the edges that are now to/from the same node
gdf_edges = gdf_edges_joined.iloc[:,0:len(gdf_edges.columns)]
gdf_edges = gdf_edges.drop(gdf_edges[gdf_edges["u"] == gdf_edges["v"]].index)

# now we're ready to convert to GMNS format
# first, the nodes
# now we have to keep the attributes of some OSM node that was merged (e.g., whether it's signalized)
# can't make a determination for every duplicate, so arbitrarily pick the first record that appears
gdf_nodes_joined = gdf_nodes_joined.drop_duplicates("index_right")
# reproject back to WGS84 lat-long to populate coordinates
gdf_nodes_joined = gdf_nodes_joined.to_crs('epsg:4326') 
gdf_nodes_joined.lon = gdf_nodes_joined.geometry.x
gdf_nodes_joined.lat = gdf_nodes_joined.geometry.y

NODE = pd.DataFrame(columns = ["node_id", "name", "x_coord", "y_coord", "z_coord", "node_type", "ctrl_type", "zone"])
NODE["node_id"] = gdf_nodes_joined.index_right
NODE["x_coord"] = gdf_nodes_joined.lon
NODE["y_coord"] = gdf_nodes_joined.lat
NODE["node_type"] = gdf_nodes_joined.highway
NODE = NODE.set_index("node_id")
NODE.to_csv("node.csv")

# next, link_geometry, which remains unchanged (except for the links that were removed for being within an intersection)
# this does create some GIS topology issues (that is, the geometries aren't all physically connected)
# but we don't use the geometry except for visualization, so there isn't an effect on the rest of GMNS 
LINK_GEOMETRY = pd.DataFrame(columns = ["link_geom_id", "name", "geometry", "length", "row_width", "jurisdiction"])
LINK_GEOMETRY["link_geom_id"] = gdf_edges.index
LINK_GEOMETRY = LINK_GEOMETRY.set_index("link_geom_id")
LINK_GEOMETRY["name"] = gdf_edges.name
LINK_GEOMETRY["facility_type"] = gdf_edges.highway_x
LINK_GEOMETRY["geometry"] = gdf_edges.geometry
LINK_GEOMETRY["length"] = gdf_edges.length
LINK_GEOMETRY["row_width"] = gdf_edges.width
LINK_GEOMETRY.to_csv("link_geometry.csv")

# now, road_link
# Note: because we chose network_type='drive' back where we pulled the network from OSM, 
# there won't be any offroad links in the network

# also,  osmnx automatically handles the oneway tag from OSM data and 
# reverses any geometry so direction of digitization is always direction of oneway travel.

ROAD_LINK_for = pd.DataFrame(columns = ["road_link_id", "name", "from_node", "to_node", "link_geom_id", "dir_flag", "capacity", "free_speed","lanes", "bike_facility", "ped_facility", "parking", "allowed_uses", "facility_type", "grade"])
# first in the forward direction
ROAD_LINK_for["name"] = gdf_edges.name
ROAD_LINK_for["from_node"] = gdf_edges.u
ROAD_LINK_for["to_node"] = gdf_edges.v
ROAD_LINK_for["link_geom_id"] = gdf_edges.index
ROAD_LINK_for["facility_type"] = gdf_edges.highway_x
ROAD_LINK_for["dir_flag"] = 1
ROAD_LINK_for["free_speed"] = gdf_edges.maxspeed
ROAD_LINK_for["lanes"] = gdf_edges.lanes
# may be able to get more attributes by editing ox.settings.useful_tags_path
ROAD_LINK_for = ROAD_LINK_for.reset_index(drop=True)

ROAD_LINK_rev = pd.DataFrame(columns = ["road_link_id", "name", "from_node", "to_node", "link_geom_id", "dir_flag", "capacity", "free_speed","lanes", "bike_facility", "ped_facility", "parking", "allowed_uses", "facility_type", "grade"])
# now do the same thing but only for links that have flow in the reverse direction (two-way streets)
gdf_edges_rev = gdf_edges[gdf_edges["oneway"]==False]
ROAD_LINK_rev["name"] = gdf_edges_rev.name
ROAD_LINK_rev["from_node"] = gdf_edges_rev.v
ROAD_LINK_rev["to_node"] = gdf_edges_rev.u
ROAD_LINK_rev["link_geom_id"] = gdf_edges_rev.index
ROAD_LINK_rev["facility_type"] = gdf_edges_rev.highway_x
ROAD_LINK_rev["dir_flag"] = -1
ROAD_LINK_rev["free_speed"] = gdf_edges_rev.maxspeed
ROAD_LINK_rev["lanes"] = gdf_edges_rev.lanes
ROAD_LINK_rev = ROAD_LINK_rev.reset_index(drop=True)

ROAD_LINK = ROAD_LINK_for.append(ROAD_LINK_rev, ignore_index=True)
ROAD_LINK = ROAD_LINK.sort_values(by = ['link_geom_id']).reset_index(drop = True)
ROAD_LINK["road_link_id"] = ROAD_LINK.index
ROAD_LINK = ROAD_LINK.set_index("road_link_id")
ROAD_LINK.to_csv("road_link.csv")

# (because osmnx combines some OSM links automatically cleaning the network up,
# there are some lists that can't be exported to a shapefile, so this converts those lists to strings)
#gdf_edges2 = gdf_edges
#for col in gdf_edges2.columns:
#    if gdf_edges2[col].dtype == object:
#        gdf_edges2[col] = np.where(pd.isnull(gdf_edges2[col]),gdf_edges2[col],gdf_edges2[col].astype(str))        
#gdf_edges2.to_file("test.shp")