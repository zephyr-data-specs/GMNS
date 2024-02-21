# Zone

The zone file locates zones on a map. This could be a Travel Analysis Zone (TAZ), city, census tract, census block, or parcel, etc. 
Zones are represented as polygons in geographic information systems.

Zone data dictionary

| Field                                   | Type     | Required? | Comment                                                                                            |
| --------------------------------------- | -------- | --------- | -------------------------------------------------------------------------------------------------- |
| <span class="underline">zone\_id</span> | Zone\_ID | Required  | Primary Key (Unique)                                                                               |
| name                                    | TEXT     | Optional  |                                                                                                    |
| boundary                                | Geometry | Optional  | The zone polygon in well-known text (WKT) format. Optionally, other formats supported by geopandas (GeoJSON, PostGIS) may be used if specified in geometry_field_format in gmns.spec.json.                                                                                   |
| super\_zone                             | Zone\_ID | Optional  | If there is a hierarchy of zones (e.g., parcels and TAZs), indicates the zone of next higher level |

Ad hoc fields may also be added.
Other numeric fields could be used for population, employment, area, etc. 
Other text fields could be used for jurisdiction, etc.
