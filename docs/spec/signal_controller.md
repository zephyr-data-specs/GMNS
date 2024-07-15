## `signal_controller`
  - `description` The signal controller is associated with an intersection or a cluster of intersections.
  - `path` signal_controller.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['controller_id']
    - `fieldsMatch` subset
  
| name          | type   | description   | constraints        |
|:--------------|:-------|:--------------|:-------------------|
| controller_id | any    | Primary key.  | {'required': True} |