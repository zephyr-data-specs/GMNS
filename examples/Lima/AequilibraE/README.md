# Running AequilibraE routing

## Requirements
⚠️This example uses AEquilibraE version 0.6.5, which is _not_ the latest version. AequilibraE dependencies include Python 3.5, 3.6 or 3.7 (3.7 is recommended), and openmatrix.  For further information, please see https://www.aequilibrae.com

Recommended steps:
1. Make sure you have a supported version of python 
2. `pip install aequilibrae==0.6.5`
3. `pip install openmatrix`

## Inputs
1. Nodes as a .csv flat file in GMNS format
2. Links as a .csv flat file in GMNS format
3. Trips as a .csv flat file, with the following columns:  orig_node, dest_node, trips
4. Sqlite database used by AequilibraE

## Steps
**In [`GMNS_AE_Integrated.ipynb`](GMNS_AE_Integrated.ipynb):**
1.  Read the GMNS nodes
    -  Place in SQLite database, then translate to AequilibraE nodes
    -  Generate the dictionary of zones for the omx trip table (uses node_type = centroid)
2. Read the GMNS links
    -  Place in SQLite database, then translate to AequilibraE links
3. Read the trips
    -  Translate into .omx file

**In [`Route.ipynb`](Route.ipynb):**

1.  Set up Aequilibrae environment
2.  Obtain the shortest path skim from the network
3.  Run routing 
4.  Generate summary statistics 

## Outputs
- Shortest path skims: `sp_skim.omx`
- Routing results: `rt_skim.omx`, `linkflow.csv`
