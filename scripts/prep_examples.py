import json
import shutil
from os import listdir
from pathlib import Path

from shared import EXAMPLES_PATH, get_package, get_package_json

# from os.path import isfile, join


package = get_package()

example_paths = [
    EXAMPLES_PATH / "Arlington_Signals",
    EXAMPLES_PATH / "Arlington_Signals_Errors",
    EXAMPLES_PATH / "Cambridge_Intersection",
    EXAMPLES_PATH / "Cambridge_Multimodal_Network",
    EXAMPLES_PATH / "Freeway_Interchange",
    EXAMPLES_PATH / "Lima" / "GMNS",
]

files_to_copy: list[tuple[str, Path]] = [
    ("use_definitions.csv", EXAMPLES_PATH / "use_definitions.csv"),
    ("use_group.csv", EXAMPLES_PATH / "use_group.csv"),
]


def prep_examples():
    # Get all files in spec_path
    # example_paths = [
    #     EXAMPLES_PATH / f
    #     for f in listdir(EXAMPLES_PATH)
    #     if not isfile(join(EXAMPLES_PATH, f))
    # ]

    for example_path in example_paths:
        for name_of_file_to_copy, path_of_file_to_copy in files_to_copy:
            if name_of_file_to_copy not in listdir(example_path):
                shutil.copyfile(
                    path_of_file_to_copy, example_path / name_of_file_to_copy
                )
        if "datapackage.json" not in listdir(example_path):
            with open(example_path / "datapackage.json", "w+") as package_file:
                json.dump(get_package_json(), package_file)


if __name__ == "__main__":
    prep_examples()
