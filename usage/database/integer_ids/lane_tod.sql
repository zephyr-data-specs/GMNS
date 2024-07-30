CREATE TABLE IF NOT EXISTS lane_tod (
	lane_tod_id INTEGER NOT NULL, 
	lane_id INTEGER NOT NULL, 
	timeday_id INTEGER, 
	time_day TEXT, 
	lane_num INTEGER NOT NULL CHECK (lane_num <= 10) CHECK (lane_num >= -10), 
	allowed_uses TEXT, 
	r_barrier TEXT, 
	l_barrier TEXT, 
	width FLOAT CHECK (width >= 0), 
	PRIMARY KEY (lane_tod_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id), 
	FOREIGN KEY(lane_id) REFERENCES lane (lane_id)
)