## `schema`

| name       | type   | description                                                                                                   | constraints        |
|:-----------|:-------|:--------------------------------------------------------------------------------------------------------------|:-------------------|
| zone_id    | any    | Primary key.                                                                                                  | {'required': True} |
| name       | string | Optional.                                                                                                     |                    |
| boundary   | any    | Optional. The polygon geometry of the zone, as well-known text.                                               |                    |
| super_zone | string | Optional. If there is a hierarchy of zones (e.g., parcels and TAZs), indicates the zone of next higher level. |                    |