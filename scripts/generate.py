# import json
from shared import gmns

if __name__ == "__main__":
    gmns.generate_docs()
    gmns.generate_db()

    # with open(SCRIPT_PATH / "datapackage.json", "w+") as file:
    #     json.dump(gmns.json_data, file)

    pass
