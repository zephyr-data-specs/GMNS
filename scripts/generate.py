from shared import DOCS_PATH, gmns

if __name__ == "__main__":
    # with open(DOCS_PATH / "README.md") as old_file:
    #     old_docs = old_file.read().split("\n")

    new_docs = gmns.generate_docs()

    # if old_docs == new_docs:
    # Change in schema detected! Generating new database...
    gmns.generate_db()

    # with open(SCRIPT_PATH / "datapackage.json", "w+") as file:
    #     json.dump(gmns.json_data, file)

    pass
