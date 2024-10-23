CREATE TABLE IF NOT EXISTS lane (
	lane_id TEXT NOT NULL, 
	link_id TEXT NOT NULL, 
	lane_num INTEGER NOT NULL CHECK (lane_num >= -10) CHECK (lane_num <= 10), 
	allowed_uses TEXT, 
	r_barrier TEXT, 
	l_barrier TEXT, 
	width FLOAT CHECK (width >= 0), 
	PRIMARY KEY (lane_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id)
)