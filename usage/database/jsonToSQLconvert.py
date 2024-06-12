# -*- coding: utf-8 -*-
"""
Created on Mon May 20 08:27:31 2024

@author: Scott
"""
import os
import json

def json_to_sql(item_name, json_data):
    # Parse JSON data
    data = json.loads(json_data)
    
    # Initialize SQL statement
    sql_statement = f"CREATE TABLE IF NOT EXISTS {item_name} (\n"
    fkey_statement = ""
    # Iterate through fields
    for field in data['fields']:
        field_name = field['name']
        field_type = field['type']
        field_description = field['description']
        
        # Determine SQL data type based on JSON value type
        if field_type == "string":
            sql_type = "VARCHAR(255)"  # Adjust size as needed
        elif field_type == "number":
            sql_type = "FLOAT"
        elif field_type == "any":
            sql_type = "VARCHAR(255)"  # Assuming "any" can be represented as string
        else:
            # Handle other types if necessary
            sql_type = "VARCHAR(255)"  # Default to string
        
        # Append column definition to SQL statement
        sql_statement += f"    {field_name} {sql_type}"
        
        # Check if field is required and add NOT NULL constraint
        if field.get('constraints', {}).get('required', False):
            sql_statement += " NOT NULL"
        
        # Add foreign key constraint if present
        if 'foreign_key' in field:
            foreign_key = field['foreign_key']
            fkey_newstring = foreign_key.replace(".", "(")
            fkey_newstring = fkey_newstring + ")"
            fkey_statement += f",\n    FOREIGN KEY ({field_name}) REFERENCES {fkey_newstring}"
        
        # Add column description as comment
        sql_statement += f",  -- {field_description}\n"
    
    # Add primary key constraint
    sql_statement += f"    PRIMARY KEY ({data['primaryKey']})"
    
    # Add foreign key(s) and closing parenthesis
    sql_statement += fkey_statement
    sql_statement += "\n);"
    
    return sql_statement

# Example JSON file format description
wd = os.getcwd()
#print(wd)
item_name = "zone"
file_path = "./spec/" + item_name + ".schema.json"
with open (file_path,"r") as file:
    my_json_data = file.read()
#print(my_json_data)


# Convert JSON to SQL statement
sql_statement = json_to_sql(item_name, my_json_data)
with open (item_name + ".sql","w") as sqlfile:
    sqlfile.write(sql_statement)