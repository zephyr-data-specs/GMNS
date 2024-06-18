import json
import os
import sqlite3
from frictionless import Package, Resource
import pathlib
from os import listdir
from os.path import isfile, join, split

# Define paths to various folders
script_path = pathlib.Path(__file__).parent.resolve()
specs_path = script_path / ".." / "spec"
docs_path = script_path / ".." / "docs" / "spec"
db_path = script_path / ".." / "usage" / "database"

# Get all files in spec_path
spec_files = [specs_path / f for f in listdir(specs_path) if isfile(join(specs_path, f))]

for spec_file in spec_files:
    # Combine every schema file into one datapackage
    if "datapackage" in split(spec_file)[1]:
        with open(spec_file) as f:
            json_data = json.load(f)
        for index, resource in enumerate(json_data["resources"]):
            if type(resource["schema"]) is str:
                with open((specs_path / resource["schema"])) as r:
                    schema_data = json.load(r)

                    json_data["resources"][index]["schema"] = schema_data

                    # Get rid of duplicate info...
                    del json_data["resources"][index]["schema"]["name"]
                    del json_data["resources"][index]["schema"]["description"]

                    filename = str(
                        json_data["resources"][index]["name"].split(".")[0] + ".md"
                    )

                    path = docs_path / filename

                    # Make documentation files for every schema/resource
                    resource = Resource(json_data["resources"][index])
                    generated_markdown = resource.to_markdown(
                        path.absolute().as_posix(),
                        True,
                    )

                    # Fix formatting to make table display properly
                    new_markdown = generated_markdown.replace("  | name", "\n  | name")

                    with open(path, "w") as resource_doc:
                        resource_doc.write(new_markdown)

        # Make package markdown file as README.md for documentation folder
        package = Package(json_data)
        package.to_markdown((docs_path / "README.md").absolute().as_posix())

        # Create blank CSV files so that we don't get errors when creating the SQLite DB
        files_to_delete = []
        for _, resource in enumerate(package.resources):
            if type(resource.path) is str:
                file_to_create = resource.path
                if not os.path.exists(file_to_create):
                    with open(file_to_create, "a+"): files_to_delete.append(file_to_create)

        # Use https://alpha.sqliteviewer.app/ for verification!
        os.remove(db_path / "gmns.sqlite")
        create_db = package.publish(f"sqlite:///{(db_path / "gmns.sqlite").absolute().as_posix()}")

        # Get list of every table and its schema
        connection = sqlite3.connect(f"{db_path.absolute().as_posix()}/gmns.sqlite")
        cursor = connection.cursor()
        cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")
        list_of_tables = cursor.fetchall()
        for table_name, table_sql in list_of_tables:
            with open(db_path / f"{table_name}.sql", "w") as table_file:
                # Add "IF NOT EXISTS" condition
                table_sql = table_sql.replace("CREATE TABLE", "CREATE TABLE IF NOT EXISTS")
                table_file.write(table_sql)
        cursor.close()
        connection.close()

        # Remove temp files we created earlier
        for file_to_delete in files_to_delete:
            os.remove(file_to_delete)
