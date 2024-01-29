# GMNS Schema
Schema for General Network Modeling Specification.

## Files in Specification

GMNS consists of a package of files as defined in the following table.

**The following table is automatically generated from `gmns.spec.json`**

{{ SPEC_TABLE }}

File components for GMNS are specified in `gmns.spec.json` in a format compatible with the
[frictionless data](https://specs.frictionlessdata.io/tabular-data-package/) data package standard.

Example `gmns.spec.json`:
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

## Data Table Schemas
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
            "name": "link_id",
            "type": "any",
            "description": "Required. Foreign key to link table. The link that the segment is located on.",
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
