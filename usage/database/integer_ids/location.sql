CREATE TABLE IF NOT EXISTS location (
	loc_id INTEGER NOT NULL, 
	link_id INTEGER NOT NULL, 
	ref_node_id INTEGER NOT NULL, 
	lr FLOAT NOT NULL CHECK (lr >= 0), 
	x_coord FLOAT, 
	y_coord FLOAT, 
	z_coord FLOAT, 
	loc_type TEXT, 
	zone_id INTEGER, 
	gtfs_stop_id INTEGER, 
	PRIMARY KEY (loc_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id), 
	FOREIGN KEY(ref_node_id) REFERENCES node (node_id)
)