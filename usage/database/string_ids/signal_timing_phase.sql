CREATE TABLE IF NOT EXISTS signal_timing_phase (
	timing_phase_id TEXT NOT NULL, 
	timing_plan_id TEXT, 
	signal_phase_num INTEGER NOT NULL CHECK (signal_phase_num >= 0), 
	min_green FLOAT CHECK (min_green >= 0), 
	max_green FLOAT CHECK (max_green >= 0), 
	extension FLOAT CHECK (extension >= 0) CHECK (extension <= 120), 
	clearance FLOAT CHECK (clearance >= 0) CHECK (clearance <= 120), 
	walk_time FLOAT CHECK (walk_time <= 120) CHECK (walk_time >= 0), 
	ped_clearance FLOAT CHECK (ped_clearance >= 0) CHECK (ped_clearance <= 120), 
	ring INTEGER NOT NULL CHECK (ring <= 12) CHECK (ring >= 0), 
	barrier INTEGER NOT NULL CHECK (barrier <= 12) CHECK (barrier >= 0), 
	position INTEGER NOT NULL, 
	PRIMARY KEY (timing_phase_id), 
	FOREIGN KEY(timing_plan_id) REFERENCES signal_timing_plan (timing_plan_id)
)