# Lima network
This folder contains examples of how to run a GMNS network using open-source tools:
* [AEquilibraE](https://github.com/AequilibraE/aequilibrae)
* [DTAlite](https://github.com/asu-trans-ai-lab/DTALite)

The source data is contained in [source_network](https://github.com/zephyr-data-specs/GMNS/tree/Lima/Small_Network_Examples/Lima/source_network) and the converted network in the [GMNS](https://github.com/zephyr-data-specs/GMNS/tree/Lima/Small_Network_Examples/Lima/GMNS) folder.
See the READMEs in the sub-folders for more details about implementation with the various packages. Other files in this top-level folder include:

* Lima.sqlite, a SQLite database containing the Lima data (nodes and links) in GMNS, DTAlite, and AEquilibraE formats. (generated using code in the respective subfolders)
* demand.csv, a flat file trip table
* link_types.csv, based on the [link_types table](http://www.aequilibrae.com/python/latest/project_docs/link_types.html) from AEquilibraE v0.7
