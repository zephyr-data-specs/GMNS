import shutil

from shared import DOCS_PATH, gmns

if __name__ == "__main__":
    # Get old docs
    with open(DOCS_PATH / "README.md") as old_file:
        old_docs = "".join(old_file.read().split("\n"))

    # Delete old doc files
    shutil.rmtree(DOCS_PATH)

    new_docs = "".join(gmns.generate_docs().split("\n"))

    if old_docs != new_docs:
        # Change in schema detected! Generating new database...
        gmns.generate_db()

    # with open(SCRIPT_PATH / "datapackage.json", "w+") as file:
    #     json.dump(gmns.json_data, file)

    pass
