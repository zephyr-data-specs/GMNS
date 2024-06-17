CREATE TABLE IF NOT EXISTS link (
	link_id TEXT NOT NULL, 
	name TEXT, 
	from_node_id TEXT NOT NULL, 
	to_node_id TEXT NOT NULL, 
	directed BOOLEAN NOT NULL, 
	geometry_id TEXT, 
	geometry TEXT, 
	parent_link_id TEXT, 
	dir_flag INTEGER, 
	length FLOAT CHECK (length >= 0), 
	grade FLOAT CHECK (grade <= 100) CHECK (grade >= -100), 
	facility_type TEXT, 
	capacity FLOAT CHECK (capacity >= 0), 
	free_speed FLOAT CHECK (free_speed <= 200) CHECK (free_speed >= 0), 
	lanes INTEGER CHECK (lanes >= 0), 
	bike_facility VARCHAR(22), 
	ped_facility VARCHAR(14), 
	parking VARCHAR(8), 
	allowed_uses TEXT, 
	toll FLOAT, 
	jurisdiction TEXT, 
	row_width FLOAT CHECK (row_width >= 0), 
	PRIMARY KEY (link_id), 
	FOREIGN KEY(parent_link_id) REFERENCES link (link_id), 
	FOREIGN KEY(to_node_id) REFERENCES node (node_id), 
	FOREIGN KEY(from_node_id) REFERENCES node (node_id), 
	FOREIGN KEY(geometry_id) REFERENCES geometry (geometry_id)
)