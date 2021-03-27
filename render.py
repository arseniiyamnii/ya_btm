#!/usr/bin/python3
import pystache
import json
import os
def chooser(ask, value):
    print(ask)
    n=0
    for i in value:
        print(str(n)+") "+str(i))
        n+=1
    number = int(input())
    return(value[number])
with open('yabtm.conf.json') as json_file:
    config = json.load(json_file)
query = {}
query["projectPath"] = str(os.getcwd())[:-11]
for i in config["fields"]:
    if(isinstance(config["fields"][i]['value'], list)):
       answ = chooser(config["fields"][i]["ask"],config["fields"][i]["value"])
       query[answ]=True
    else:
        query[i]= input(config["fields"][i]["ask"])
for i in config["files"]:
    temp_file = open("template/"+i, "r")
    outfile = pystache.render(temp_file.read(), query)
    temp_file.close()
    temp_file = open("template/"+i, "w")
    temp_file.write(outfile)

