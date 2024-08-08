CREATE TABLE IF NOT EXISTS signal_detector (
	detector_id TEXT NOT NULL, 
	controller_id TEXT NOT NULL, 
	signal_phase_num INTEGER NOT NULL, 
	link_id TEXT NOT NULL, 
	start_lane INTEGER NOT NULL, 
	end_lane INTEGER, 
	ref_node_id TEXT NOT NULL, 
	det_zone_lr FLOAT NOT NULL, 
	det_zone_front FLOAT, 
	det_zone_back FLOAT, 
	det_type TEXT, 
	PRIMARY KEY (detector_id), 
	FOREIGN KEY(ref_node_id) REFERENCES node (node_id), 
	FOREIGN KEY(controller_id) REFERENCES signal_controller (controller_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id)
)