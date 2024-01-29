# GMNSpy
 Python tool for [General Modeling Network Specification (GMNS)](https://github.com/zephyr-data-specs/GMNS) developed
 by [Zephyr  Foundation](http://zephyrtransport.org) for Travel Analysis.

# Installation

 ```sh
 git clone https://github.com/e-lo/GMNSpy.git
 cd GMNSpy
 pip install .
 ```

### Install Development Tools

 `pip install -r dev-requirements.txt`

# Usage

## Read a single file

 Returns a dataframe that conforms to the specified schema and have been
 validated.

 ```python
 df = gmnspy.in_out.read_gmns_csv(data_filename, schema_file=schemafilename)
 ```
 ## Read a network

 Returns a dictionary of dataframes that conform to the specified schema
 and have been validated.

 Checks foreign keys between files.

 ```python
 net = gmnspy.in_out.read_gmns_network(data_directory, config: "gmns.spec.json")
 ```

# GMNS specification
 The GMNS specification is maintained in the `/spec` sub-directory as a
 series of JSON tables. 

## Data Table schemas
 Data table schemas are specified in JSON and are compatible with the
 [frictionless data](https://specs.frictionlessdata.io/table-schema/) table
 schema standards.

 Example:
 ```JSON
 {
     "primaryKey": "segment_id",
     "missingValues": ["NaN",""],
     "fields": [
         {
             "name": "segment_id",
             "type": "any",
             "description": "Primary key.",
             "constraints": {
               "required": true,
               "unique": true
               }
         },
         {
             "name": "road_link_id",
             "type": "any",
             "description": "Required. Foreign key to road_links. The link that the segment is located on.",
             "foreign_key": "link.link_id",
             "constraints": {
               "required": true
               }
         },
         {
             "name": "ref_node_id",
             "type": "any",
             "description": "Required. Foreign key to node.",
             "foreign_key": "node.node_id",
             "constraints": {
               "required": true
               }
         },
         {
             "name": "start_lr",
             "type": "number",
             "description": "Required. Distance from ref_node_id.",
             "constraints": {
               "required": true,
               "minimum": 0
               }
         },
         {
             "name": "end_lr",
             "type": "number",
             "description": "Required. Distance from ref_node_id.",
             "constraints": {
               "required": true,
               "minimum": 0
               }
           }
     ]
 }

 ```

 ## Network Data Config
 Network data schemas are specified in JSON and are compatible with the
 [frictionless data](https://specs.frictionlessdata.io/tabular-data-package/) data package standards.

 Example:
 ```JSON
 {
   "profile": "gmns-data-package",
   "profile_version":0.0,
   "name": "my-dataset",
   "resources": [
    {
      "name":"link",
      "path": "link.csv",
      "schema": "link.schema.json",
      "required": true
    },
    {
      "name":"node",
      "path": "node.csv",
      "schema": "node.schema.json",
      "required": true
    }
  ]
 }
 ```

# Issues

Please add issues, bugs, and feature requests [to Github](https://github.com/e-lo/GMNSpy).

# Development

Current feature roadmap includes:

 - converion tools from open street map
 - network connectivity checks
 - auto documentation of schema to markdown files
 - tests tests tests

Feel free to submit pull requests for consideration.

# Credits

 Author: Elizabeth Sall, UrbanLabs LLC
