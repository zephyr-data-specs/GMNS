CREATE TABLE IF NOT EXISTS curb_seg (
    curb_seg_id VARCHAR(255) NOT NULL,  -- Primary key.
    link_id VARCHAR(255) NOT NULL,  -- Required. Foreign key to road_links. The link that the segment is located on.
    ref_node_id VARCHAR(255) NOT NULL,  -- Required. Foreign key to node where distance is 0.
    start_lr FLOAT NOT NULL,  -- Required. Distance from `ref_node_id` in short_length units.
    end_lr FLOAT NOT NULL,  -- Required. Distance from `ref_node_id`in short_length units.
    regulation VARCHAR(255),  -- Optional. Regulation on this curb segment.
    width FLOAT,  -- Optional. Width (short_length units) of the curb segment.
    PRIMARY KEY (curb_seg_id),
    FOREIGN KEY (link_id) REFERENCES link(link_id),
    FOREIGN KEY (ref_node_id) REFERENCES node(node_id)
);