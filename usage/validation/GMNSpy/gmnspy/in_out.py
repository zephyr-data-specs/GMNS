import os

import pandas as pd

from .validate import (
    apply_schema_to_df,
    confirm_required_files,
    update_resources_based_on_existence,
    validate_foreign_keys,
)
from .schema import read_config


def read_gmns_csv(
    filename: str, validate: bool = True, schema_file: str = None
) -> pd.DataFrame:
    """
    Reads csv and returns it as a dataframe; optionally coerced to the
    types as specified in the data schema.

    Args:
        filename: file location of the csv file to read in.
        validate: boolean whether to apply the specified schema to the dataframe. Default is True.
        schema_file: file location of the schema to validate the file to.

    Returns: Validated dataframe with coerced types according to schema.
    """

    df = pd.read_csv(filename)

    if validate:
        apply_schema_to_df(df, schema_file=schema_file, originating_file=filename)
    else:
        print("not validating {}".format(filename))

    return df


def read_gmns_network(
    data_directory: str, config: str = os.path.join("spec", "gmns.spec.json")
) -> dict:
    """
    Reads each GMNS file as specified in the config and validates it to
    their specified schema including foreign keys between the tables.

    Args:
        data_directory: Directory where GMNS data is.
        config: Configuration file. A json file with a list of "resources"
            specifying the "name", "path", and "schema" for each GMNS table as
            well as a boolean value for "required". If not specified, assumes
            it is in a subdirectory "spec/gmns.spec.json"
            Example:
            ::
                {
                  "resources": [
                   {
                     "name":"link",
                     "path": "link.csv",
                     "schema": "link.schema.json",
                     "required": true
                   },
                   {
                     "name":"node",
                     "path": "node.csv",
                     "schema": "node.schema.json",
                     "required": true
                   }
                 }
    returns: a dictionary mapping the name of each GMNS table to a
        validated dataframe.
    """
    gmns_net_d = {}
    resource_df = read_config(config, data_dir=data_directory)

    # check required files exist,
    confirm_required_files(resource_df)

    # update resource dictionary based on what files are in the directory
    resource_df = update_resources_based_on_existence(resource_df)

    # read each csv to a df and validate format
    for _, row in resource_df.iterrows():
        gmns_net_d[row["name"]] = read_gmns_csv(row["fullpath"], schema_file=row["fullpath_schema"])

    # validate foreign keys
    validate_foreign_keys(gmns_net_d, resource_df)

    return gmns_net_d
