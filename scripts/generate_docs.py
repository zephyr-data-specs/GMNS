import json
from frictionless import Package, Resource
import pathlib
from os import listdir
from os.path import isfile, join, split


current_path = pathlib.Path(__file__).parent.resolve()
specs_path = current_path / ".." / "spec"
docs_path = current_path / ".." / "docs" / "spec"

onlyfiles = [specs_path / f for f in listdir(specs_path) if isfile(join(specs_path, f))]

for file in onlyfiles:
    if "datapackage" in str(file):
        with open(file) as f:
            json_data = json.load(f)
        for index, resource in enumerate(json_data["resources"]):
            if type(resource["schema"]) is str:
                with open((specs_path / resource["schema"])) as r:
                    schema_data = json.load(r)

                    json_data["resources"][index]["schema"] = schema_data

                    del json_data["resources"][index]["schema"]["name"]
                    del json_data["resources"][index]["schema"]["description"]

                    path = (docs_path / f"{split(json_data["resources"][index]['name'])[-1].split('.')[0]}.md")

                    resource = Resource(json_data["resources"][index])
                    generated_markdown = resource.to_markdown(
                        path
                        .absolute()
                        .as_posix(),
                        True,
                    )

                    new_markdown = generated_markdown.replace("  | name", "\n  | name")
                    print(new_markdown)

                    with open(path, "w") as file1:
                        file1.write(new_markdown)

                    
        package = Package(json_data)
        # er_diagram = package.to_er_diagram((docs_path / "diagram.dot").absolute().as_posix())

        # package.image = er_diagram
        # pprint(package)

        package.to_markdown((docs_path / "README.md").absolute().as_posix())
