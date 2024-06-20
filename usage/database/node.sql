CREATE TABLE IF NOT EXISTS node (
	node_id TEXT NOT NULL, 
	name TEXT, 
	x_coord FLOAT NOT NULL, 
	y_coord FLOAT NOT NULL, 
	z_coord FLOAT, 
	node_type TEXT, 
	ctrl_type VARCHAR(6), 
	zone_id TEXT, 
	parent_node_id TEXT, 
	PRIMARY KEY (node_id), 
	FOREIGN KEY(parent_node_id) REFERENCES node (node_id), 
	FOREIGN KEY(zone_id) REFERENCES zone (zone_id)
)