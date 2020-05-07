# Zone

The zone file locates zones (travel analysis zones, parcels) on a map.
Zones are represented as polygons in geographic information systems.

| Field                                   | Type     | Required? | Comment                                                                                            |
| --------------------------------------- | -------- | --------- | -------------------------------------------------------------------------------------------------- |
| <span class="underline">Zone\_ID</span> | Zone\_ID | Required  | Primary Key (Unique)                                                                               |
| Zone\_Name                              | TEXT     | Optional  |                                                                                                    |
| Boundary                                | Geometry | Required  | The zone polygon                                                                                   |
| Super\_Zone                             | Zone\_ID | Optional  | If there is a hierarchy of zones (e.g., parcels and TAZs), indicates the zone of next higher level |

Ad hoc fields may also be added.
Other numeric fields could be used for population, employment, area, etc. 
Other text fields could be used for jurisdiction, etc.