CREATE TABLE IF NOT EXISTS signal_phase_mvmt (
	signal_phase_mvmt_id INTEGER NOT NULL, 
	timing_phase_id INTEGER NOT NULL, 
	mvmt_id INTEGER, 
	link_id INTEGER, 
	protection TEXT, 
	PRIMARY KEY (signal_phase_mvmt_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id), 
	FOREIGN KEY(mvmt_id) REFERENCES movement (mvmt_id), 
	FOREIGN KEY(timing_phase_id) REFERENCES signal_timing_phase (timing_phase_id)
)