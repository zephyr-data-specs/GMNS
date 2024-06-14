CREATE TABLE zone (
	zone_id TEXT NOT NULL, 
	name TEXT, 
	boundary TEXT, 
	super_zone TEXT, 
	PRIMARY KEY (zone_id), 
	FOREIGN KEY(super_zone) REFERENCES zone (zone_id)
)