# Validation Tools
This directory includes demonstrations of code for each of these types of validation, stored in the Jupyter Notebook format. These tools were developed for machines running Windows, and may not work with other operating systems.  

## [Format_Validation.ipynb](Format_Validation.ipynb)

This notebook demonstrates validation of whether a GMNS network conforms to the specification. It uses a [modified version](https://github.com/ianberg-volpe/GMNSpy/tree/hide_output) of the GMNSpy package originally developed by [Elizabeth Sall](https://github.com/e-lo/GMNSpy). The script takes as input a directory containing a GMNS network stored as CSV files, and a machine-readable version of the specification stored as JSON files that are compatible with the [Frictionless Table Schema](https://specs.frictionlessdata.io/table-schema/). It checks each file that makes up the network for conformance to the specification, and reports failure and warning messages if it does not conform.

## [Graph_Validation.ipynb](Graph_Validation.ipynb)

This notebook demonstrates validation on graph representations of GMNS networks. Graph properties such as connectedness and node neighborhood size are demonstrated on a small, multimodal network containing a handful of intersections. A demonstration on a larger network, derived from [open-source data](https://atlantaregional.org/I85BridgeCollapseDataset) from the Atlanta Regional Commission, shows how circuity (the ratio between the straight-line and shortest-path distances between zone centroids) can be used to explore the validity of a network.
