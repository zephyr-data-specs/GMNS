CREATE TABLE IF NOT EXISTS use_definition (
    use VARCHAR(255) NOT NULL,  -- Primary key
    persons_per_vehicle FLOAT NOT NULL,  -- Required.
    pce FLOAT NOT NULL,  -- Required. Passenger car equivalent.
    special_conditions VARCHAR(255),  -- Optional.
    description VARCHAR(255),  -- Optional 
    PRIMARY KEY (use)
);