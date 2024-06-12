CREATE TABLE IF NOT EXISTS use_group (
    use_group VARCHAR(255) NOT NULL,  -- Primary key.
    uses VARCHAR(255) NOT NULL,  -- Comma-separated list of uses.
    description VARCHAR(255),  -- Optional.
    PRIMARY KEY (use_group)
);