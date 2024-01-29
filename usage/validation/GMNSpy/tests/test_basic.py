import os
import glob
import gmnspy
import pytest

base_path = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))

# https://github.com/zephyr-data-specs/GMNS/edit/master/Small_Network_Examples/Multiple_Bike_Facilities/road_link.csv

test_data = [
    "link", "geometry", "node", "use_definition", "use_group",
    ]
schemas = glob.glob("**/*.schema.json", recursive=True)

@pytest.mark.travis
def test_read_schema():
    schema_file = os.path.join(base_path, "spec", "link.schema.json")
    s = gmnspy.read_schema(schema_file)
    print(s)

@pytest.mark.travis
@pytest.mark.parametrize("test_data_name", test_data)
def test_validate_dfs(test_data_name):
    df = gmnspy.in_out.read_gmns_csv("tests/data/" + test_data_name + ".csv",)
    print(df[0:3])

@pytest.mark.travis
def test_validate_relationships():
    net = gmnspy.in_out.read_gmns_network(os.path.join(base_path, "tests", "data"))

@pytest.mark.travis
@pytest.mark.elo
@pytest.mark.parametrize("schema_file", schemas)
def test_read_schema(schema_file):
    #schema_file = os.path.join(base_path, "spec", "link.schema.json")
    print("reading"+schema_file)
    s = gmnspy.read_schema(schema_file)
    s_md = gmnspy.list_to_md_table(s['fields'])
    print(s_md)
