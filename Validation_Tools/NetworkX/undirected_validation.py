# GMNS Validation Tool: Undirected Validation With NetworkX

# Inputs: Nodes.csv and Links.csv from a GMNS formatted network
# (required: the optional field Node_Type in the Nodes.csv)

# Output: Prints to screen information and warnings:
## First, a warning highlights nodes that may have too many or too few neighbors based on their Node_Type
## Second, either a statement that the network is connected; or, a list of links not connected to the largest component
## Third, a list of isolated nodes, which should be reviewed by the user
## Fourth, the network is drawn on the screen (without shape information)

import networkx as nx
import pandas as pd

# importing the GNMS node and link files
df_nodes = pd.read_csv(r'node.csv', index_col='node_id') # Replace with the path to your nodes file
df_edges = pd.read_csv(r'road_link.csv', index_col='road_link_id') # Replace with the path to your links file

df_nodes['node_id'] = df_nodes.index
df_edges['road_link_id'] = df_edges.index

# creating the graph
#(note: multigraphs allow for multiple edges to be defined by the same pair of nodes, which we might need)
# it automatically creates a key to distinguish between edges with same pair of nodes
G = nx.from_pandas_edgelist(df_edges, 'from_node', 'to_node', True, nx.MultiGraph)

# adding the node attributes
for i in G.nodes():
    G.node[i]['x_coord'] = df_nodes.x_coord[i]
    G.node[i]['y_coord'] = df_nodes.y_coord[i]
    G.node[i]['pos'] = (G.node[i]['x_coord'],G.node[i]['y_coord']) # for drawing
    G.node[i]['node_type'] = df_nodes.node_type[i]
    # add other attributes as needed

# flagging where a node's number of neighbors 
# another possible option is node degree (number of edges including the node): replace len(G[i]) with G.degree(i) in the code below
# user will have to interpret these results based on their network
for i in sorted(G.nodes()): 
    # print("Node: ", i, " has total degree: ", G.degree(i))
    if (len(G[i]) == 1 and G.node[i]['node_type'] != 'External'):
        print("Check node: ", i, " for connectivity; it appears to be external but is not labeled that way.")
    if (len(G[i]) == 2):
        print("Check node: ", i, " to see if it is necessary")
    if (len(G[i]) > 3 and G.node[i]['node_type'] in ['Merge','Diverge']): 
        print("Check node: ", i, " for extra connections; it is a merge/diverge with more than three connecting links")

# checking connectivity
if nx.is_connected(G):
    print("The network is connected.")
else:
    # list of nodes in the largest component of the graph
    largest_cc = max(nx.connected_components(G), key=len)
    for a,b,key,link in G.edges(data='road_link_id', keys=True):
        if a not in largest_cc:
            # (only need to test one node since a in component & a-b an edge implies b in component)
            print("The road link with ID ", link, " is not connected to the network.")
            # These links will need to be cleaned up before using the network in a model.

for v in nx.isolates(G):
    print("The node with ID " + str(v) + " is isolated (has no edges)")
    # These nodes should be reviewed to see if they can be deleted

# drawing (from Woburn code)
import matplotlib.pyplot as plt
pos = nx.get_node_attributes(G,'pos')
nx.draw(G, pos, with_labels=True)
plt.show()
