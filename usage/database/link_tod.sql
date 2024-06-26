CREATE TABLE IF NOT EXISTS link_tod (
	link_tod_id TEXT NOT NULL, 
	link_id TEXT NOT NULL, 
	timeday_id TEXT, 
	time_day TEXT, 
	capacity FLOAT CHECK (capacity >= 0), 
	free_speed FLOAT CHECK (free_speed >= 0) CHECK (free_speed <= 200), 
	lanes INTEGER CHECK (lanes >= 0), 
	bike_facility VARCHAR(22), 
	ped_facility VARCHAR(14), 
	parking VARCHAR(8), 
	allowed_uses TEXT, 
	toll FLOAT, 
	PRIMARY KEY (link_tod_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id)
)