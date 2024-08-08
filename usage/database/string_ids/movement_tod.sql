CREATE TABLE IF NOT EXISTS movement_tod (
	mvmt_tod_id TEXT NOT NULL, 
	mvmt_id TEXT NOT NULL, 
	time_day TEXT, 
	timeday_id TEXT, 
	ib_link_id TEXT NOT NULL, 
	start_ib_lane INTEGER, 
	end_ib_lane INTEGER, 
	ob_link_id TEXT NOT NULL, 
	start_ob_lane INTEGER, 
	end_ob_lane INTEGER, 
	type TEXT NOT NULL, 
	penalty FLOAT, 
	capacity FLOAT, 
	ctrl_type TEXT, 
	mvmt_code TEXT, 
	allowed_uses TEXT, 
	PRIMARY KEY (mvmt_tod_id), 
	FOREIGN KEY(ib_link_id) REFERENCES link (link_id), 
	FOREIGN KEY(ob_link_id) REFERENCES link (link_id), 
	FOREIGN KEY(mvmt_id) REFERENCES movement (mvmt_id), 
	FOREIGN KEY(timeday_id) REFERENCES time_set_definitions (timeday_id)
)