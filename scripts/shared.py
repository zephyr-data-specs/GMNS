import pathlib
from os import listdir
from os.path import isfile, join, split

# Define paths to various folders
script_path = pathlib.Path(__file__).parent.resolve()
specs_path = script_path / ".." / "spec"
docs_path = script_path / ".." / "docs" / "spec"
db_path = script_path / ".." / "usage" / "database"

# Get all files in spec_path
spec_files = [
    specs_path / f for f in listdir(specs_path) if isfile(join(specs_path, f))
]
