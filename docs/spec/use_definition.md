## `use_definition`
  - `description` The Use_Definition file defines the characteristics of each vehicle type or non-travel purpose (e.g., a shoulder or parking lane). A two-way left turn lane (TWLTL) is also a use.
  - `path` use_definition.csv
  - `schema`
      - `missingValues` ['NaN']
    - `primaryKey` ['use']

  | name                | type   | description                         | constraints                      |
|:--------------------|:-------|:------------------------------------|:---------------------------------|
| use                 | string | Primary key                         | {'required': True}               |
| persons_per_vehicle | number | Required.                           | {'required': True, 'minimum': 0} |
| pce                 | number | Required. Passenger car equivalent. | {'required': True, 'minimum': 0} |
| special_conditions  | string | Optional.                           |                                  |
| description         | string | Optional                            |                                  |