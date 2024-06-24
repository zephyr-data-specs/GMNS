import json

from frictionless import Package
from shared import docs_path, specs_path

# Grab general package data
with open(specs_path / "datapackage.json") as spec_file:
    json_data = json.load(spec_file)

# Combine every schema file into one datapackage
for index, resource in enumerate(json_data["resources"]):
    if type(resource["schema"]) is str:
        with open((specs_path / resource["schema"])) as r:
            schema_data = json.load(r)

            json_data["resources"][index]["schema"] = schema_data

            # Get rid of duplicate info...
            del json_data["resources"][index]["schema"]["name"]
            del json_data["resources"][index]["schema"]["description"]


# Make package markdown file as README.md for documentation folder
package = Package(json_data)
package.to_markdown((docs_path / "README.md").absolute().as_posix())


def get_package():
    return package


def get_resources():
    return package.resources
