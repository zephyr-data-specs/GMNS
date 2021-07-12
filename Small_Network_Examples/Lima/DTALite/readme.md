# Lima network routed in DTALite

## Inputs
The input data was initially created by running `insertDTALiteLinks.sql` on the sqlite database in the parent folder. This query:
- Sets capacity in veh/hr  (GMNS links use veh/hr/lane)
- Inserts values for the VDF parameters

Afterwards, the following changes were made to `link.csv` and `node.csv`:

- Changed x/y coordinates from projected (feet) to degrees (WGS84)
- Distance in miles, not feet
- Removed `VDF_fftt` column in links
- In nodes, made zone match node number for centroids
- In links, changed `link_type` to 99 for centroid connectors.

## Steps
1. Clone DTALite from its [GitHub repo](https://github.com/asu-trans-ai-lab/DTALite).
2. Put `demand.csv`, `link.csv`, `node.csv`, and `settings.csv` from this folder in the DTALite's release folder.
3. Run `dtalite.exe`.

Sample output files (`agent.csv` and `link_performance.csv`) also appear in this folder. 
