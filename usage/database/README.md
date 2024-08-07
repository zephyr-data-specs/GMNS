# GMNS networks in a database
Although GMNS is implementation-agnostic, some users may find it convenient to place GMNS-formatted networks into a relational database. Use of a database is OPTIONAL. This folder contains an SQLite database, as well as the sql create statements.  There are two versions:
-  Integer_ids: The ID fields (primary and foreign keys on the tables) are stored as integers
-  Text_ids:  The ID fields (primary and foreign keys on the tables) are stored as text
