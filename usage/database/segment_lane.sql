CREATE TABLE IF NOT EXISTS segment_lane (
	segment_lane_id TEXT NOT NULL, 
	segment_id TEXT NOT NULL, 
	lane_num INTEGER NOT NULL CHECK (lane_num <= 10) CHECK (lane_num >= -10), 
	parent_lane_id TEXT, 
	allowed_uses TEXT, 
	r_barrier VARCHAR(10), 
	l_barrier VARCHAR(10), 
	width FLOAT CHECK (width >= 0), 
	PRIMARY KEY (segment_lane_id), 
	FOREIGN KEY(segment_id) REFERENCES segment (segment_id)
)