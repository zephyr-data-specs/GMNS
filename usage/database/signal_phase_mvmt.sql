CREATE TABLE IF NOT EXISTS signal_phase_mvmt (
	signal_phase_mvmt_id TEXT NOT NULL, 
	timing_phase_id TEXT NOT NULL, 
	mvmt_id TEXT, 
	link_id TEXT, 
	protection VARCHAR(9), 
	PRIMARY KEY (signal_phase_mvmt_id), 
	FOREIGN KEY(timing_phase_id) REFERENCES signal_timing_phase (timing_phase_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id), 
	FOREIGN KEY(mvmt_id) REFERENCES movement (mvmt_id)
)