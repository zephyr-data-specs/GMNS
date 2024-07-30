import shutil

from frictionless import Field
from shared import DB_PATH, DOCS_PATH, check_if_id, gmns

if __name__ == "__main__":
    # Get old docs
    with open(DOCS_PATH / "README.md") as old_file:
        old_docs = "".join(old_file.read().split("\n"))

    # Delete old doc files
    shutil.rmtree(DOCS_PATH)

    new_docs = "".join(gmns.generate_docs().split("\n"))

    if old_docs != new_docs:
        # Change in schema detected! Generating new database...
        # gmns.generate_db()

        # Make integer ID database
        gmns.edit_spec_types(check_if_id, "integer")
        gmns.generate_db(base_path=DB_PATH / "integer_ids")

        # Make string ID database
        gmns.edit_spec_types(check_if_id, "string")
        gmns.generate_db(base_path=DB_PATH / "string_ids")

    # with open(SCRIPT_PATH / "datapackage.json", "w+") as file:
    #     json.dump(gmns.json_data, file)

    pass
