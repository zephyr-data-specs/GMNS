## Config

Provides the units of measure, coordinate systems, and other metadata about a GMNS dataset. This table must contain a single row.

data dictionary
Field        | Type | Required | Comment
-------------|------|----------|--------
dataset_name | any  | optional | Name used to describe this GMNS network
short_length | any  | optional | Length unit used for lane/ROW widths and linear references for segments, locations, etc. along links
long_length  | any  | optional | Length unit used for link lengths
speed        | any  | optional | Units for speed. Usually long_length units per hour
crs          | any  | optional | Coordinate system used for geometry data in this dataset. Preferably a string that can be accepted by pyproj (e.g., EPSG code or proj string)
geometry_field_format | any  | optional | The format used for geometry fields in the dataset. For example, `WKT` for files stored as plaintext
currency     | any  | optional | Currency used in toll fields
version_number | number | optional | The version of the GMNS spec to which this dataset conforms