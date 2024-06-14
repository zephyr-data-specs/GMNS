## `config`
  - `description` Configuration information for the dataset (units, coordinate systems, etc.).
  - `path` config.csv
  - `schema`
      - `missingValues` ['NaN']
    - `numRows` 1

  | name                  | type   | description                                                                                                                                   |
|:----------------------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------|
| dataset_name          | any    | Name used to describe this GMNS network                                                                                                       |
| short_length          | any    | Length unit used for lane/ROW widths and linear references for segments, locations, etc. along links                                          |
| long_length           | any    | Length unit used for link lengths                                                                                                             |
| speed                 | any    | Units for speed. Usually long_length units per hour                                                                                           |
| crs                   | any    | Coordinate system used for geometry data in this dataset. Preferably a string that can be accepted by pyproj (e.g., EPSG code or proj string) |
| geometry_field_format | any    | The format used for geometry fields in the dataset. For example, `WKT` for files stored as plaintext                                          |
| currency              | any    | Currency used in toll fields                                                                                                                  |
| version_number        | number | The version of the GMNS spec to which this dataset conforms                                                                                   |