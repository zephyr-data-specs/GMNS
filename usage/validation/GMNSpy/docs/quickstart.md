# Installation

```sh
git clone https://github.com/e-lo/GMNSpy.git
cd GMNSpy
pip install .
```

### Install Development Tools

`pip install -r dev-requirements.txt`

# Usage

## Read a single file

Returns a dataframe that conforms to the specified schema and have been
validated.

```python
df = gmnspy.in_out.read_gmns_csv(data_filename, schema_file=schemafilename)
```
## Read a network

Returns a dictionary of dataframes that conform to the specified schema
and have been validated.

Checks foreign keys between files.

```python
net = gmnspy.in_out.read_gmns_network(data_directory, config: "gmns.spec.json")
```
