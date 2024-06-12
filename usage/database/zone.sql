CREATE TABLE IF NOT EXISTS zone (
    zone_id VARCHAR(255) NOT NULL,  -- Primary key.
    name VARCHAR(255),  -- Optional.
    boundary VARCHAR(255),  -- Optional. The polygon geometry of the zone.
    super_zone VARCHAR(255),  -- Optional. If there is a hierarchy of zones (e.g., parcels and TAZs), indicates the zone of next higher level.
    PRIMARY KEY (zone_id),
    FOREIGN KEY (super_zone) REFERENCES (zone_id)
);