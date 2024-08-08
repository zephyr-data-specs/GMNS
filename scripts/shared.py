import csv
import json
import os
import pathlib
import shutil
import sqlite3
from os import listdir
from os.path import isfile
from pathlib import Path
from typing import Callable

from frictionless import Field, Package

SCRIPT_PATH = pathlib.Path(__file__).parent.resolve()
SPECS_PATH = SCRIPT_PATH / ".." / "spec"
DOCS_PATH = SCRIPT_PATH / ".." / "docs" / "spec"
DB_PATH = SCRIPT_PATH / ".." / "usage" / "database"
EXAMPLES_PATH = SCRIPT_PATH / ".." / "examples"


def check_if_id(field: Field):
    return "_id" in field.name


class GMNS:
    """GMNS class that can be reused throughout different scripts"""

    # Define paths to various folders

    def __init__(self):
        # Grab general package data
        with open(SPECS_PATH / "datapackage.json") as spec_file:
            json_data = json.load(spec_file)

        # Combine every schema file into one datapackage
        for index, resource in enumerate(json_data["resources"]):
            if type(resource["schema"]) is str:
                with open((SPECS_PATH / resource["schema"])) as r:
                    schema_data = json.load(r)

                    json_data["resources"][index]["schema"] = schema_data

                    # Get rid of duplicate or uneccessary info...
                    del json_data["resources"][index]["schema"]["name"]
                    del json_data["resources"][index]["schema"]["description"]
                    del json_data["resources"][index]["schema"]["$schema"]

        del json_data["$schema"]
        self._package = Package(json_data)
        self._json_data = json_data

    @property
    def package(self):
        """Get the generated GMNS package"""

        return self._package

    @property
    def resources(self):
        """Get the list of resources in the GMNS package (equivalent to `package.resources`)"""

        return self._package.resources

    @property
    def json_data(self):
        """Get the generated raw JSON data for the GMNS package"""
        return self._json_data

    def generate_docs(self, base_path=DOCS_PATH):
        """Create various documentation files inside the `DOCS_FOLDER` directory."""

        # Make package markdown file as README.md for documentation folder
        package_md_path = base_path / "README.md"

        package_md = self._package.to_markdown(
            package_md_path.absolute().as_posix()
        ).replace("- `description`", "\n- `description`")

        with open(package_md_path, "w") as package_doc:
            package_doc.write(package_md)

        for resource in self._package.resources:
            resource_md_path = base_path / (resource.name + ".md")

            resource_markdown = resource.to_markdown(
                resource_md_path.absolute().as_posix(),
                True,
            ).replace("  | name", "  \n| name")

            with open(resource_md_path, "w") as resource_doc:
                resource_doc.write(resource_markdown)

        return package_md

    def generate_db(self, base_path=DB_PATH, db_name="gmns", gen_sql_files=True):
        """Create a GMNS database according to the specification"""

        # Create blank CSV files so that we don't get errors when creating the SQLite DB
        new_to_old: dict[str, str] = {}
        files_to_delete: list[Path] = []
        for resource in self._package.resources:
            if type(resource.path) is str:
                new_resource_path = base_path / resource.path
                new_to_old[
                    new_resource_path.relative_to(SCRIPT_PATH / "..").as_posix()
                ] = resource.path
                resource.path = new_resource_path.relative_to(
                    SCRIPT_PATH / ".."
                ).as_posix()

                if not os.path.exists(new_resource_path):
                    with open(new_resource_path, "a+"):
                        files_to_delete.append(new_resource_path)

        # Use https://alpha.sqliteviewer.app/ for verification!
        if isfile(base_path / f"{db_name}.sqlite"):
            os.remove(base_path / f"{db_name}.sqlite")
        self._package.publish(
            "sqlite:///" + (base_path / f"{db_name}.sqlite").absolute().as_posix()
        )

        if gen_sql_files:
            # Get list of every table and its schema
            with sqlite3.connect(base_path / f"{db_name}.sqlite") as connection:
                for table_name, table_sql in connection.execute(
                    "SELECT name, sql FROM sqlite_master WHERE type='table';"
                ):
                    with open(base_path / f"{table_name}.sql", "w") as table_file:
                        # Add "IF NOT EXISTS" condition
                        table_sql = table_sql.replace(
                            "CREATE TABLE", "CREATE TABLE IF NOT EXISTS"
                        )
                        table_file.write(table_sql)

        # Remove temp files we created earlier
        for file_to_delete in files_to_delete:
            os.remove(file_to_delete)

        # Change all resource paths back
        for resource in self._package.resources:
            if type(resource.path) is str:
                resource.path = new_to_old[resource.path]

    def prep_examples(
        self,
        examples: list[tuple[str, Path]] | None = None,
        copy_files: list[tuple[str, Path]] | None = None,
    ):
        """Generate example databases using values from params"""

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

            id_type = "any"
            try:
                with open(example_path / "config.csv", "r") as config_file:
                    config_found = True
                    config = csv.DictReader(config_file)
                    for row in config:
                        id_type = row["id_type"]
            except:
                config_found = False

            if config_found:
                self.edit_spec_types(check_if_id, id_type)

            self.generate_db(example_path, example_name, False)

            if config_found:
                self.edit_spec_types(check_if_id, "any")

        for file_to_delete in files_to_delete:
            os.remove(file_to_delete)

    def edit_spec_types(
        self, check_field: Callable[[Field], bool], change_type_to: str
    ):
        for resource in self._package.resources:
            schema = resource.schema
            for field in schema.fields:
                if check_field(field):
                    schema.set_field_type(field.name, change_type_to)

    def validate_example(
        self,
        example_path: Path,
        copy_files: list[tuple[str, Path]] | None = None,
        create_blank_files: bool = False,
    ):
        os.chdir(SCRIPT_PATH)

        if copy_files is None:
            copy_files = []

        new_to_old: dict[str, str] = {}
        files_to_delete: list[Path] = []
        for resource in self._package.resources:
            if type(resource.path) is str:
                new_resource_path = example_path / resource.path
                new_to_old[new_resource_path.relative_to(SCRIPT_PATH).as_posix()] = (
                    resource.path
                )
                resource.path = new_resource_path.relative_to(SCRIPT_PATH).as_posix()

                if not os.path.exists(new_resource_path) and create_blank_files:
                    with open(new_resource_path, "a+"):
                        files_to_delete.append(new_resource_path)

        for name_of_file_to_copy, path_of_file_to_copy in copy_files:
            if name_of_file_to_copy not in listdir(example_path):
                shutil.copyfile(
                    path_of_file_to_copy, example_path / name_of_file_to_copy
                )
                files_to_delete.append(example_path / name_of_file_to_copy)

        report = self._package.validate()

        for file_to_delete in files_to_delete:
            os.remove(file_to_delete)

        for resource in self._package.resources:
            if type(resource.path) is str:
                resource.path = new_to_old[resource.path]

        return report


gmns = GMNS()
gmns = GMNS()
