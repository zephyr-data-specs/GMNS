import json
import pathlib
from os import listdir
from os.path import isfile, join

from frictionless import Package

# Define paths to various folders
SCRIPT_PATH = pathlib.Path(__file__).parent.resolve()
SPECS_PATH = SCRIPT_PATH / ".." / "spec"
DOCS_PATH = SCRIPT_PATH / ".." / "docs" / "spec"
DB_PATH = SCRIPT_PATH / ".." / "usage" / "database"
EXAMPLES_PATH = SCRIPT_PATH / ".." / "examples"

# Grab general package data
with open(SPECS_PATH / "datapackage.json") as spec_file:
    json_data = json.load(spec_file)

# Combine every schema file into one datapackage
for index, resource in enumerate(json_data["resources"]):
    if type(resource["schema"]) is str:
        with open((SPECS_PATH / resource["schema"])) as r:
            schema_data = json.load(r)

            json_data["resources"][index]["schema"] = schema_data

            # Get rid of duplicate info...
            del json_data["resources"][index]["schema"]["name"]
            del json_data["resources"][index]["schema"]["description"]

package = Package(json_data)


def get_package():
    return package


def get_resources():
    return package.resources


def get_package_json():
    return json_data
