# Lima network
This folder contains examples of how to run a GMNS network using open-source tools:
* [AEquilibraE](https://github.com/AequilibraE/aequilibrae)
* [DTAlite](https://github.com/asu-trans-ai-lab/PythonDTALite)

The source data is contained in [source_network](/source_network) and the converted network in the [GMNS](/gmns) folder.
See the READMEs in the sub-folders for more details about implementation with the various packages. Other files in this top-level folder include:

* Lima.sqlite, a SQLite database containing the Lima data (nodes and links) in GMNS, DTAlite, and AEquilibraE formats. (generated using code in the respective subfolders)
* demand.csv, a flat file trip table
* link_types.csv, based on the [link_types table](http://www.aequilibrae.com/python/latest/project_docs/link_types.html) from AEquilibraE v0.7
