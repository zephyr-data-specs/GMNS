## `use_group`
  - `description` Defines groupings of uses, to reduce the size of the allowed_uses lists in the other tables.
  - `path` use_group.csv
  - `schema`
      - `missingValues` ['NaN']
    - `primaryKey` ['use_group']

  | name        | type   | description                   | constraints        |
|:------------|:-------|:------------------------------|:-------------------|
| use_group   | string | Primary key.                  | {'required': True} |
| uses        | string | Comma-separated list of uses. | {'required': True} |
| description | string | Optional.                     |                    |