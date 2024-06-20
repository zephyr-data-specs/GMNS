CREATE TABLE IF NOT EXISTS use_definition (
	use TEXT NOT NULL, 
	persons_per_vehicle FLOAT NOT NULL CHECK (persons_per_vehicle >= 0), 
	pce FLOAT NOT NULL CHECK (pce >= 0), 
	special_conditions TEXT, 
	description TEXT, 
	PRIMARY KEY (use)
)