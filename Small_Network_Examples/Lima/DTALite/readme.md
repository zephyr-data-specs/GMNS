# Lima network routed in DTALite

## Steps
1. Clone DTALite from its [GitHub repo](https://github.com/asu-trans-ai-lab/DTALite).
2. Put `demand.csv`, `link.csv`, `node.csv`, and `settings.csv` from this folder in the DTALite's release folder.
3. Run `dtalite.exe`.

Sample output files (`agent.csv` and `link_performance.csv`) also appear in this folder. 

The `insertDTALiteLinks.sql` script creates links in DTALite format from the Lima.sqlite database in the Lima folder.