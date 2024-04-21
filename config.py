import json 
import yaml

def call_config():
    """This Function is Reading the Config File
    Returns:config -> contains config file contents
    """
    with open("config.json","r") as conf :
        config=yaml.safe_load(conf)
    return config
