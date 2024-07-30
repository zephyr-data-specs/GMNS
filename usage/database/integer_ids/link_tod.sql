CREATE TABLE IF NOT EXISTS link_tod (
	link_tod_id INTEGER NOT NULL, 
	link_id INTEGER NOT NULL, 
	timeday_id INTEGER, 
	time_day TEXT, 
	capacity FLOAT CHECK (capacity >= 0), 
	free_speed FLOAT CHECK (free_speed <= 200) CHECK (free_speed >= 0), 
	lanes INTEGER CHECK (lanes >= 0), 
	bike_facility TEXT, 
	ped_facility TEXT, 
	parking TEXT, 
	allowed_uses TEXT, 
	toll FLOAT, 
	PRIMARY KEY (link_tod_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id)
)