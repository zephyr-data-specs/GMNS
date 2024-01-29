# GMNS Validation Tool: Directed Validation With NetworkX


# Inputs: Node.csv and Road_Link.csv from a GMNS formatted network

# Output: Prints to screen each pair of possible "to" and "from" nodes, where a path was not found
#       Also prints the total number of valid paths

# NOTE: This method is not able to handle turn restrictions
# The user will need to interpret the results of this output based on their network (no "fatal" errors to be reported)
# In a large network, there may be millions of to-from combinations, which will take many hours to run.  

import networkx as nx
import pandas as pd

# importing the GNMS node and link files
df_nodes = pd.read_csv(r'node.csv', index_col='node_id') # Replace with the path to your nodes file
df_edges = pd.read_csv(r'link.csv', index_col='link_id') # Replace with the path to your links file

# only get the directed portion
df_edges = df_edges.astype({'directed': 'bool'})
df_edges = df_edges[df_edges['directed'] == True]

df_nodes['node_id'] = df_nodes.index
df_edges['link_id'] = df_edges.index

# creating the graph
# DiGraph creates directed graph, doesn't need to be multigraph
# because we don't actually care about the minimum weight of a path, just whether one exists

G = nx.DiGraph()
G = nx.from_pandas_edgelist(df_edges, 'from_node_id', 'to_node_id', True, nx.DiGraph)
# G.add_edges_from(nx.from_pandas_edgelist(df_edges[df_edges['BA_NumberOfLanes'] > 0], 'B_node', 'A_node', True, nx.DiGraph).edges)

# adding the node attributes
for i in G.nodes():
    try:
        G.nodes[i]['x_coord'] = df_nodes.x_coord[i]
        G.nodes[i]['y_coord'] = df_nodes.y_coord[i]
        G.nodes[i]['pos'] = (G.nodes[i]['x_coord'],G.nodes[i]['y_coord']) # for drawing
        G.nodes[i]['node_type'] = df_nodes.node_type[i]  # could be used in future to filter out "fatal" issues
                                                    # e.g. path exists to an external node that only has inbound travel lanes
    except:
        print(i," not on node list")
    
    # add other attributes as needed

validPaths = 0
for i in G.nodes():
    if i < 3034:   # Hack to select only low numbered nodes (e.g., centroids in a typical network)
        toCheck = list(G.nodes())
        toCheck.remove(i)
        for j in toCheck:
            if j < 3034:   # Hack to select only low numbered nodes (e.g., centroids in a typical network)
                if nx.has_path(G,i,j):
                    validPaths = validPaths + 1
                    if validPaths % 1000 == 0:
                        print(validPaths)
                else:
                    print(i, j, nx.has_path(G, i, j))
print(validPaths," valid paths")
