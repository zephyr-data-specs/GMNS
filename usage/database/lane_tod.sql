CREATE TABLE IF NOT EXISTS lane_tod (
	lane_tod_id TEXT NOT NULL, 
	lane_id TEXT NOT NULL, 
	timeday_id TEXT, 
	time_day TEXT, 
	lane_num INTEGER NOT NULL CHECK (lane_num >= -10) CHECK (lane_num <= 10), 
	allowed_uses TEXT, 
	r_barrier VARCHAR(10), 
	l_barrier VARCHAR(10), 
	width FLOAT CHECK (width >= 0), 
	PRIMARY KEY (lane_tod_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id), 
	FOREIGN KEY(lane_id) REFERENCES lane (lane_id)
)