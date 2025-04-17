CREATE TABLE IF NOT EXISTS segment_tod (
	segment_tod_id TEXT NOT NULL, 
	segment_id TEXT NOT NULL, 
	timeday_id TEXT, 
	time_day TEXT, 
	capacity FLOAT CHECK (capacity >= 0), 
	free_speed FLOAT CHECK (free_speed <= 200) CHECK (free_speed >= 0), 
	lanes INTEGER, 
	l_lanes_added INTEGER, 
	r_lanes_added INTEGER, 
	bike_facility TEXT, 
	ped_facility TEXT, 
	parking TEXT, 
	toll FLOAT, 
	allowed_uses TEXT, 
	PRIMARY KEY (segment_tod_id), 
	FOREIGN KEY(segment_id) REFERENCES segment (segment_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id)
)