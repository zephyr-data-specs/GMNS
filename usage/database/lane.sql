CREATE TABLE lane (
	lane_id TEXT NOT NULL, 
	link_id TEXT NOT NULL, 
	lane_num INTEGER NOT NULL CHECK (lane_num <= 10) CHECK (lane_num >= -10), 
	allowed_uses TEXT, 
	r_barrier VARCHAR(10), 
	l_barrier VARCHAR(10), 
	width FLOAT CHECK (width >= 0), 
	PRIMARY KEY (lane_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id)
)