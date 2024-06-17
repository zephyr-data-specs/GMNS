CREATE TABLE segment_tod (
	segment_tod_id TEXT NOT NULL, 
	segment_id TEXT NOT NULL, 
	timeday_id TEXT, 
	time_day TEXT, 
	capacity FLOAT CHECK (capacity >= 0), 
	free_speed FLOAT CHECK (free_speed >= 0) CHECK (free_speed <= 200), 
	lanes INTEGER, 
	l_lanes_added INTEGER, 
	r_lanes_added INTEGER, 
	bike_facility VARCHAR(22), 
	ped_facility VARCHAR(14), 
	parking VARCHAR(14), 
	toll FLOAT, 
	allowed_uses TEXT, 
	PRIMARY KEY (segment_tod_id), 
	FOREIGN KEY(segment_id) REFERENCES segment (segment_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id)
)