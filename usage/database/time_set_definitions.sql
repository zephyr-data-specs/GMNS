CREATE TABLE time_set_definitions (
	timeday_id TEXT NOT NULL, 
	monday BOOLEAN NOT NULL, 
	tuesday BOOLEAN NOT NULL, 
	wednesday BOOLEAN NOT NULL, 
	thursday BOOLEAN NOT NULL, 
	"Friday" BOOLEAN NOT NULL, 
	saturday BOOLEAN NOT NULL, 
	sunday BOOLEAN NOT NULL, 
	holiday BOOLEAN NOT NULL, 
	start_time TIME NOT NULL, 
	end_time TIME NOT NULL, 
	PRIMARY KEY (timeday_id)
)