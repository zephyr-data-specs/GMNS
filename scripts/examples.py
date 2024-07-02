from pathlib import Path

from shared import gmns

EXAMPLES_PATH = gmns.EXAMPLES_PATH

# List of tuples with the database name and path to the relevant example folder
EXAMPLE_PATHS: list[tuple[str, Path]] = [
    ("cambridge", EXAMPLES_PATH / "Cambridge_Intersection"),
]

# Template files that should be present in every example
FILES_TO_COPY: list[tuple[str, Path]] = [
    ("use_definition.csv", EXAMPLES_PATH / "use_definition.csv"),
    ("use_group.csv", EXAMPLES_PATH / "use_group.csv"),
]


if __name__ == "__main__":
    gmns.prep_examples(EXAMPLE_PATHS, FILES_TO_COPY)
    pass
