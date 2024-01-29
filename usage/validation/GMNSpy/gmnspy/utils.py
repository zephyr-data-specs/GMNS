

def list_to_md_table(list_of_dicts: list) -> str:
    """
    Reads a list of dictionaries defining a schema and creates a markdown table.

    args:
        list_of_dicts: a list of dictionaries containing definition of fields.

    returns: A markdown string representing the table.

    """
    # flatten dictionary
    flat_list = []
    for i in list_of_dicts:
        flat_list.append({k:v for k,v in _recursive_items(i)})

    # get all items listed
    standard_header_items =  ["name","required","type","foreign_key","description",]
    additional_header_items = list(set([k for i in flat_list for k,v in i.items()])-set(standard_header_items))
    header_items = standard_header_items + sorted(additional_header_items)

    header_md = "|"+"|".join(header_items)+"|\n"
    header_md += "|---"*len(header_items)+"|\n"

    body_md = ''
    for d in flat_list:
        body_md += "|" + "|".join([_format_cell_by_type(d.get(i,"-"),i) for i in header_items]) +  "|\n"

    return header_md + body_md

def _format_cell_by_type(x,header):
    if "enum" in header  and len(x)>1:
        return "Allowed Values: `"+",".join(map(str,x))+"`"
    if header is "foreign_key" and len(x)>1:
        table, var = x.split(".")
        if table == "":
            return "Variable: `{}`".format(var)
        return "Table: `{}`, Variable: `{}`".format(table, var)
    else:
        return str(x)

def _recursive_items(d: dict, key_prefix: str=''):
    """
    Recursively flattens a nested dictionary and returns a dictionary with key_prefixe
    to represent original nesting structures.

    Modified from https://stackoverflow.com/questions/39233973/get-all-keys-of-a-nested-dictionary
    """
    for k,v in d.items():
        if type(v) is dict:
            yield from _recursive_items(v,key_prefix=k+" ")
        elif k=="required":
            yield (k,v)
        else:
            yield (key_prefix+k,v)
