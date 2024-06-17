CREATE TABLE IF NOT EXISTS curb_seg (
	curb_seg_id TEXT NOT NULL, 
	link_id TEXT NOT NULL, 
	ref_node_id TEXT NOT NULL, 
	start_lr FLOAT NOT NULL CHECK (start_lr >= 0), 
	end_lr FLOAT NOT NULL CHECK (end_lr >= 0), 
	regulation TEXT, 
	width FLOAT CHECK (width >= 0), 
	PRIMARY KEY (curb_seg_id), 
	FOREIGN KEY(link_id) REFERENCES link (link_id), 
	FOREIGN KEY(ref_node_id) REFERENCES node (node_id)
)