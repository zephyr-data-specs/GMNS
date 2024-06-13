import json
from frictionless import Package, Schema
import pathlib
from os import listdir
from os.path import isfile, join, split
from pprint import pprint


current_path = pathlib.Path(__file__).parent.resolve()
specs_path = current_path / '..' / 'spec'
docs_path = current_path / '..' / 'docs' / 'spec'

onlyfiles = [specs_path / f for f in listdir(specs_path) if isfile(join(specs_path, f))]

for file in onlyfiles:
    if "schema" in str(file):
        schema = Schema.from_descriptor(file.absolute().as_posix())
        schema.to_markdown((docs_path / f"{split(file)[-1].split('.')[0]}.md").absolute().as_posix(), True)
    elif "datapackage" in str(file):
        with open(file) as f:
            json_data = json.load(f)
        for index, resource in enumerate(json_data['resources']):
            if type(resource['schema']) is str:
                with open((specs_path / resource['schema'])) as r:
                    schema_data = json.load(r)
                    del schema_data['name']
                    del schema_data['description']
                    json_data['resources'][index]['schema'] = schema_data
        package = Package(json_data)
        # er_diagram = package.to_er_diagram((docs_path / "diagram.dot").absolute().as_posix())

        # package.image = er_diagram
        # pprint(package)

        package.to_markdown((docs_path / "README.md").absolute().as_posix())
        