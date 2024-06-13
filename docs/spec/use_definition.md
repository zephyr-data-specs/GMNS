## `schema`

| name                | type   | description                         | constraints                      |
|:--------------------|:-------|:------------------------------------|:---------------------------------|
| use                 | string | Primary key                         | {'required': True}               |
| persons_per_vehicle | number | Required.                           | {'required': True, 'minimum': 0} |
| pce                 | number | Required. Passenger car equivalent. | {'required': True, 'minimum': 0} |
| special_conditions  | string | Optional.                           |                                  |
| description         | string | Optional                            |                                  |