## `zone`
  - `description` Locates zones (travel analysis zones, parcels) on a map. Zones are represented as polygons in geographic information systems.
  - `path` zone.csv
  - `schema`
      - `missingValues` ['NaN', '']
    - `primaryKey` ['zone_id']
    - `foreignKeys`
      - [1]
        - `fields` ['super_zone']
        - `reference`
          - `resource` 
          - `fields` ['zone_id']
    - `fieldsMatch` subset
  
| name       | type   | description                                                                                                   | constraints        |
|:-----------|:-------|:--------------------------------------------------------------------------------------------------------------|:-------------------|
| zone_id    | any    | Primary key.                                                                                                  | {'required': True} |
| name       | string | Optional.                                                                                                     |                    |
| boundary   | any    | Optional. The polygon geometry of the zone, as well-known text.                                               |                    |
| super_zone | string | Optional. If there is a hierarchy of zones (e.g., parcels and TAZs), indicates the zone of next higher level. |                    |