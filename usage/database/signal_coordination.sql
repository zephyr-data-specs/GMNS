CREATE TABLE IF NOT EXISTS signal_coordination (
	coordination_id TEXT NOT NULL, 
	timing_plan_id TEXT NOT NULL, 
	controller_id TEXT NOT NULL, 
	coord_contr_id TEXT, 
	coord_phase INTEGER CHECK (coord_phase <= 32) CHECK (coord_phase >= 0), 
	coord_ref_to VARCHAR(15), 
	"offset" FLOAT CHECK ("offset" >= 0), 
	PRIMARY KEY (coordination_id), 
	FOREIGN KEY(controller_id) REFERENCES signal_controller (controller_id), 
	FOREIGN KEY(timing_plan_id) REFERENCES signal_timing_plan (timing_plan_id), 
	FOREIGN KEY(coord_contr_id) REFERENCES signal_controller (controller_id)
)