CREATE TABLE location (
	loc_id TEXT NOT NULL, 
	link_id TEXT NOT NULL, 
	ref_node_id TEXT NOT NULL, 
	lr FLOAT NOT NULL CHECK (lr >= 0), 
	x_coord FLOAT, 
	y_coord FLOAT, 
	z_coord FLOAT, 
	loc_type TEXT, 
	zone_id TEXT, 
	gtfs_stop_id TEXT, 
	PRIMARY KEY (loc_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id), 
	FOREIGN KEY(ref_node_id) REFERENCES node (node_id)
)