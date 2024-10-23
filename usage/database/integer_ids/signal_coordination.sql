CREATE TABLE IF NOT EXISTS signal_coordination (
	coordination_id INTEGER NOT NULL, 
	timing_plan_id INTEGER NOT NULL, 
	controller_id INTEGER NOT NULL, 
	coord_contr_id INTEGER, 
	coord_phase INTEGER CHECK (coord_phase <= 32) CHECK (coord_phase >= 0), 
	coord_ref_to TEXT, 
	"offset" FLOAT CHECK ("offset" >= 0), 
	PRIMARY KEY (coordination_id), 
	FOREIGN KEY(coord_contr_id) REFERENCES signal_controller (controller_id), 
	FOREIGN KEY(timing_plan_id) REFERENCES signal_timing_plan (timing_plan_id), 
	FOREIGN KEY(controller_id) REFERENCES signal_controller (controller_id)
)