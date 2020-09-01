#%% SETUP
"""
GMNS to NetworkWrangler
"""
import pandas as pd
import json
from copy import deepcopy

#set units of gmns length
l_unit = 'feet'#'meters' 'miles'
if l_unit == 'meters':
    l_conv = 1
    d_conv = 0.00062137
if l_unit == 'feet':
    l_conv = 0.3048
    d_conv = 0.00018939
if l_unit == 'miles':
    l_conv = 1609.3
    d_conv = 1
    
# importing the GNMS node and link files
df_nodes = pd.read_csv('node.csv',index_col='node_id') # Replace with the path to your node file
df_links = pd.read_csv('link.csv',index_col='link_id') # Replace with the path to your link file
df_geoms = pd.read_csv('geometry.csv',index_col='geometry_id') # Replace with the path to your geometry file
df_locs = pd.read_csv('location.csv', index_col='loc_id') # Replace with the path to your segment file


df_nodes['node_id'] = df_nodes.index
df_links['link_id'] = df_links.index
df_geoms['geometry_id'] = df_geoms.index
df_locs['loc_id'] = df_locs.index

df_nodes = df_nodes.fillna('')
df_links = df_links.fillna('')
df_geoms = df_geoms.fillna('')
df_locs = df_locs.fillna('')


#%% GEOMETRY
nw_geom_lst = []
nw_geom_def = {
            "type": "Feature",
            "geometry": {
                "type": "LineString",
                "coordinates": []
            },
            "properties": {
                "id": "default",
                "fromIntersectionId": '',
                "toIntersectionId": '',
                "forwardReferenceId": ''
                #"backReferenceId" is optional
            }
        }

for geom in df_geoms.itertuples():
    #create geometry based on the default
    nw_geom = deepcopy(nw_geom_def)
    
    nw_geom['properties']['id'] = str(geom.geometry_id)
    
    #reformat from linestring to a list of coordinates then add to NW feature
    line = geom.geometry.split(r"(")[1][:-1]
    line = line.split(',')
    for point in line:
        if point[0] == ' ':
            point = point[1:]
        coords = point.split(' ')
        coord_lst = [float(coords[0]), float(coords[1])]
        nw_geom['geometry']['coordinates'].append(coord_lst)
    nw_geom_lst.append(nw_geom.copy())
       

#%% LINKS

nw_links=[]
nw_link_def = {
    "model_link_id": 0,
    "osm_link_id": "",
    "shstReferenceId": "",
    "shstGeometryId": "",
    "u": "",
    "v": "",
    "A": 0,
    "B": 0,
    "access": "",
    "area": "",
    "bridge": "",
    "highway": "",
    "length": 0,
    "maxspeed": "",
    "name": "",
    "oneway": "False",
    "tunnel": "",
    "width": "",
    "lanes": 0,
    "distance": 0.0,
    "HOV_access": 0,
    "trn_priority": 0,
    "ttime_assert": 0,
    "transit_access": 0,
    "drive_access": 0,
    "walk_access": 0,
    "bike_access": 0,
    "transit_walk_access": 0,
    "locationReferences": [
      {
        "sequence": 1,
        "point": [
          0.000000,
          0.000000
        ],
        "distanceToNextRef": 0.0000000,
        "bearing": 0,
        "intersectionId": ''
      },
      {
        "sequence": 2,
        "point": [
          0.000000,
          0.000000
        ],
        "intersectionId": ''
      }
    ]
  }



for link in df_links.itertuples():
    ##create the link based on the default
    nw_link = deepcopy(nw_link_def)

    ##go through each attribute of the network wrangler link and get the attribute from GMNS
    #model_link_id, other IDs (ignoring references to shared streets)
    nw_link["model_link_id"] = link.link_id #NW takes an int name
    nw_link["osm_link_id"] = str(link.link_id)
    nw_link["shstReferenceId"] = str(link.link_id)
    
    #geometry:
    #check if a geometry exists for the link
    if link.geometry_id == '' and link.geometry == '':
        #if geometry doesn't exist, remove the unnecessary location reference
        link_geom_exists = 0
        del nw_link["locationReferences"][-1]

    elif link.geometry_id != '':
        link_geom_exists = 1
        #note start and end node for location reference
        nw_link["locationReferences"][0]["intersectionId"] = str(link.from_node_id)
        nw_link["locationReferences"][1]["intersectionId"] = str(link.to_node_id)

    elif link.geometry != '':
        link_geom_exists = 2
        #note start and end node for location reference
        nw_link["locationReferences"][0]["intersectionId"] = str(link.from_node_id)
        nw_link["locationReferences"][1]["intersectionId"] = str(link.to_node_id)
        
    #the next steps are based on what form of geometry the link has

    #if there is a linked geometry:        
    if link_geom_exists == 1:
        #add the geometry id to the NW link  
        nw_link["shstGeometryId"] = str(link.geometry_id)
        #find the matching NW geometry
        for nw_geom in nw_geom_lst:
            if nw_geom['properties']['id'] == str(link.geometry_id):
                #check if the geometry already has a from and toIntersectionId
                if nw_geom['properties']['fromIntersectionId'] == '':
                    #if not, add them
                    #first double check what direction this link is in, if it's reversed make sure to reverse intersectionIds
                    if link.dir_flag == -1:
                        nw_geom['properties']['fromIntersectionId'] = str(link.to_node_id)
                        nw_geom['properties']['toIntersectionId'] = str(link.from_node_id)
                       
                    else:
                        nw_geom['properties']['fromIntersectionId'] = str(link.from_node_id)
                        nw_geom['properties']['toIntersectionId'] = str(link.to_node_id)
            
                #check if there is a referenced link for this geometry, if not, add one
                #first, check if this is a backReference or a forwardReference
                if link.dir_flag == -1:
                    if not 'backReferenceId' in nw_geom['properties'].keys(): 
                        nw_geom['properties']['backReferenceId'] = str(link.link_id)
                    
                elif nw_geom['properties']['forwardReferenceId'] == '':
                    nw_geom['properties']['forwardReferenceId'] = str(link.link_id)
                    
                #add start and end coordinates to the link locationReferences
                if link.dir_flag == -1:
                    nw_link["locationReferences"][0]["point"] = nw_geom["geometry"]["coordinates"][-1]
                    nw_link["locationReferences"][1]["point"] = nw_geom["geometry"]["coordinates"][0]
                else:
                    nw_link["locationReferences"][0]["point"] = nw_geom["geometry"]["coordinates"][0]
                    nw_link["locationReferences"][1]["point"] = nw_geom["geometry"]["coordinates"][-1]
                #exit the for loop after the matching geometry has been located and updated
                break
            
    #if the geometry field is used instead:
    elif link_geom_exists == 2:
        #if there isn't, run through the geometry to make sure an identical geometry doesn't already exist
        #reformat from linestring to a list of coordinates to be able to match them to the geometry coordinates
        coord_lsts = []
        line = link.geometry.split(r"(")[1][:-1]
        line = line.split(',')
        for point in line:
            coords = point.split(' ')
            coord_lst = [float(coords[0]), float(coords[1])]
            coord_lsts.append(coord_lst)
        #run through each already read geometry file
        geom_dne = True #tag to change if a geometry is found
        for nw_geom in nw_geom_lst:
            #check if there's an identical geometry already
            if nw_geom['geometry']['coordinates'] == coord_lsts:
                geom_dne = False
                #if there is: add this link to the properties of the geometry
                #check if the geometry alreadyhas a from and toIntersectionId
                if nw_geom['properties']['fromIntersectionId'] == '':
                    #if not, add them
                    #first double check what direction this link is in, if it's reversed make sure to reverse intersectionIds
                    if link.dir_flag == -1:
                        nw_geom['properties']['fromIntersectionId'] = str(link.to_node_id)
                        nw_geom['properties']['toIntersectionId'] = str(link.from_node_id)
                    else:
                        nw_geom['properties']['fromIntersectionId'] = str(link.from_node_id)
                        nw_geom['properties']['toIntersectionId'] = str(link.to_node_id)
                
                #add forward/backReferenceIds and locationReferences
                if link.dir_flag == -1:
                    nw_link["locationReferences"][0]["point"] = nw_geom["geometry"]["coordinates"][-1]
                    nw_link["locationReferences"][1]["point"] = nw_geom["geometry"]["coordinates"][0]
                    if not 'backReferenceId' in nw_geom['properties'].keys(): 
                        nw_geom['properties']['backReferenceId'] = str(link.link_id)
                    
                else:
                    if nw_geom['properties']['forwardReferenceId'] == 'default':
                        nw_geom['properties']['forwardReferenceId'] = str(link.link_id)
                    nw_link["locationReferences"][0]["point"] = nw_geom["geometry"]["coordinates"][0]
                    nw_link["locationReferences"][1]["point"] = nw_geom["geometry"]["coordinates"][1]
                
                #exit the for loop after the geometry is found and updated
                break
            
        #if there is not already an existing geometry, make one
        if geom_dne:     
            #create new NW geometry based on the default
            nw_geom = deepcopy(nw_geom_def)
            #give the new geometry an id based on the link
            nw_geom['properties']['id'] = str(link.link_id) + '_geom'
            #tie the link to the geometry with the geometry id
            nw_link["shstGeometryId"] = str(link.link_id) + '_geom'
            #add the geometry to the NW geometry
            for coord_lst in coord_lsts:
                nw_geom['geometry']['coordinates'].append(coord_lst)
            #check if link and geometry direction are the same or opposite
            if link.dir_flag == -1:
                #if opposite, set Ids for link and nodes but make sure they are reversed
                nw_geom['properties']['backReferenceId'] = str(link.link_id)
                nw_geom['properties']['fromIntersectionId'] = str(link.to_node_id)
                nw_geom['properties']['toIntersectionId'] = str(link.from_node_id)
                nw_link["locationReferences"][0]["point"] = nw_geom["geometry"]["coordinates"][-1]
                nw_link["locationReferences"][1]["point"] = nw_geom["geometry"]["coordinates"][0]
            else:
                #if not opposite, set Ids for link and nodes in the same direction
                nw_geom['properties']['forwardReferenceId'] = str(link.link_id)
                nw_geom['properties']['fromIntersectionId'] = str(link.from_node_id)
                nw_geom['properties']['toIntersectionId'] = str(link.to_node_id)
                nw_link["locationReferences"][0]["point"] = nw_geom["geometry"]["coordinates"][0]
                nw_link["locationReferences"][1]["point"] = nw_geom["geometry"]["coordinates"][-1]
            #add the new NW geometry to the NW geometry collection
            nw_geom_lst.append(nw_geom.copy())
            

    
    #sets to and from nodes (continuing to ignore shared streets)
    nw_link["u"] = str(link.from_node_id)
    nw_link["v"] = str(link.to_node_id)
    nw_link["A"] = link.from_node_id #NW has as an int type but GMNS might be a string
    nw_link["B"] = link.to_node_id #NW has as an int type but GMNS might be a string
    
    #access, area and bridge left as default
    
    #facility type -> highway
    nw_link["highway"] = str(link.facility_type)
    
    #length -> length in meters
    try:
        nw_link["length"] = round(l_conv*link.length, 3)
        nw_link["locationReferences"][0]["distanceToNextRef"] = nw_link["length"]
    except TypeError:
        nw_link["length"] = ''
    
    #freespeed -> maxspeed
    nw_link["maxspeed"] = str(link.free_speed) + ' mph'
    
    #name -> name
    nw_link["name"] = str(link.name)
    
    #directed -> oneway
    #if the link is directed and there isn't a comparable link going in the opposite direction in the same space then we assume it is one-way
    if link.directed == True:
        if (
            (df_links.from_node_id == link.to_node_id) 
            & (df_links.to_node_id == link.from_node_id) 
            & (df_links.link_id != link.link_id) 
            & (df_links.directed == True)
            ).any() == False:
            
            nw_link["oneway"] = "True"

    #tunnel left as default
    
    #row_width (ft) -> width (meters)
    try:
        nw_link["width"] = round(0.3048 * link.row_width, 3)
    except TypeError:
        nw_link["width"] = ''
        
    #lanes -> lanes
    try:
        nw_link["lanes"] = int(link.lanes)
    except:
        nw_link["lanes"] = ''
    
    #length -> distance (miles)
    try:
        nw_link["distance"] = round(d_conv * link.length, 3)
    except TypeError:
        nw_link["distance"] = ''

    #allowed_uses -> HOV_access
    if "hov" in link.allowed_uses.lower() is True:
        nw_link["HOV_access"] = 1
    
    #allowed_uses -> transit access
    if "bus" in link.allowed_uses.lower() or "rail" in link.allowed_uses.lower():
        nw_link["transit_access"] = 1
    if (df_locs.link_id == link.link_id).any():
        df_temp = df_locs.loc[df_locs.link_id == link.link_id]
        for loc in df_temp.itertuples():
            if "transit" in loc.loc_type.lower() or "bus" in loc.loc_type.lower() or "rail" in loc.loc_type.lower():
                nw_link["transit_access"] = 1
                break
        del df_temp
    #allowed_uses -> drive_access
    if "auto" in link.allowed_uses.lower():
        nw_link["drive_access"] = 1
        
    #allowed_uses -> walk_access
    if "walk" in link.allowed_uses.lower():
        nw_link["walk_access"] = 1
    elif link.ped_facility != '' and link.ped_facility.lower() != 'none':
        nw_link["walk_access"] = 1
    
    #allowed_uses -> bike_access
    if "bike" in link.allowed_uses.lower():
        nw_link["bike_access"] = 1
    elif link.bike_facility != '' and link.bike_facility.lower() != 'none':
        nw_link["bike_access"] = 1
    
    #transit_walk_access left as default      
    
    #add updated link to network wrangler link file
    nw_links.append(nw_link)

with open('link.json', 'w') as json_file:
  json.dump(nw_links, json_file, indent=4)

nw_geoms = { "type": "FeatureCollection", "features":nw_geom_lst} 
with open('shape.geojson', 'w') as json_file:
  json.dump(nw_geoms, json_file, indent=4)

#%% NODES  
nw_node_def = {
          "type": "Feature",
          "geometry": {
              "type": "Point",
              "coordinates": [
                  00.0000000,
                  00.0000000
              ]
          },
          "properties": {
              "shstReferenceId": "0",
              "osm_node_id": "0",
              "model_node_id": 0,
              "transit_node": 0,
              "drive_node": 0,
              "walk_node": 0,
              "bike_node": 0,
              "outboundReferenceId": [
              ],
              "inboundReferenceId": [
              ]
          }
      }

nw_nodes_lst = []  

for node in df_nodes.itertuples():
    ##create the link based on the default
    nw_node = deepcopy(nw_node_def)
    
    ##go through each attribute of the network wrangler link and get the attribute from GMNS
    
    #get coordinates
    nw_node["geometry"]["coordinates"][0] = float(node.x_coord)
    nw_node["geometry"]["coordinates"][1] = float(node.y_coord)
    
    #get primary keys
    nw_node["properties"]["shstReferenceId"] = str(node.node_id)
    nw_node["properties"]["osm_node_id"] = str(node.node_id)
    nw_node["properties"]["model_node_id"] = node.node_id #NW wants an int type but GMNS doesn't have that req
    
    ##NODE TYPES
    for nw_link in nw_links:
            if nw_link['u'] == str(node.node_id) or nw_link['v'] == str(node.node_id):
                if nw_node["properties"]["transit_node"] == 0 and nw_link["transit_access"] == 1:
                    nw_node["properties"]["transit_node"] = 1
                if nw_node["properties"]["drive_node"] == 0 and nw_link["drive_access"] == 1:
                    nw_node["properties"]["drive_node"] = 1
                if nw_node["properties"]["walk_node"] == 0 and nw_link["walk_access"] == 1:
                    nw_node["properties"]["walk_node"] = 1
                if nw_node["properties"]["bike_node"] == 0 and nw_link["bike_access"] == 1:
                    nw_node["properties"]["bike_node"] = 1
            #while iterating through links, get outbound and inboundReferenceId's
            if nw_link['u'] == str(node.node_id):
                nw_node["properties"]["outboundReferenceId"].append(str(nw_link["model_link_id"]))
            if nw_link['v'] == str(node.node_id):
                nw_node["properties"]["inboundReferenceId"].append(str(nw_link["model_link_id"]))

    #add updated node to network wrangler node file
    nw_nodes_lst.append(nw_node.copy())  
    
nw_nodes = { "type": "FeatureCollection", "features":nw_nodes_lst} 
with open('node.geojson', 'w') as json_file:
  json.dump(nw_nodes, json_file, indent=4)