import os
import shutil
from os import listdir
from pathlib import Path

from generate import generate_db
from shared import EXAMPLES_PATH, get_package

package = get_package()

# List of tuples with the database name and path to the relevant example folder
EXAMPLE_PATHS: list[tuple[str, Path]] = [
    ("cambridge", EXAMPLES_PATH / "Cambridge_Intersection"),
]

# Template files that should be present in every example
FILES_TO_COPY: list[tuple[str, Path]] = [
    ("use_definition.csv", EXAMPLES_PATH / "use_definition.csv"),
    ("use_group.csv", EXAMPLES_PATH / "use_group.csv"),
]


def prep_examples(
    examples: list[tuple[str, Path]] | None = None,
    copy_files: list[tuple[str, Path]] | None = None,
):
    if examples is None:
        examples = []

    if copy_files is None:
        copy_files = []

    files_to_delete: list[Path] = []
    for example_name, example_path in examples:
        for name_of_file_to_copy, path_of_file_to_copy in copy_files:
            if name_of_file_to_copy not in listdir(example_path):
                shutil.copyfile(
                    path_of_file_to_copy, example_path / name_of_file_to_copy
                )
                files_to_delete.append(example_path / name_of_file_to_copy)
        generate_db(example_path, example_name, False)

    for file_to_delete in files_to_delete:
        os.remove(file_to_delete)


if __name__ == "__main__":
    prep_examples(EXAMPLE_PATHS, FILES_TO_COPY)
    pass
