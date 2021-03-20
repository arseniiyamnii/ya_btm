#!/usr/bin/python3
import pystache
import json

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
print(config)
query = {}
for i in config["fields"]:
    #    if(isinstance(i, str)):
    #print(config["fields"][i])
    print(type(config["fields"][i]['value']))
    if(isinstance(config["fields"][i]['value'], list)):
       #config["fields"][i]["temp"] = chooser(config["fields"][i]["ask"],config["fields"][i]["value"])
       answ = chooser(config["fields"][i]["ask"],config["fields"][i]["value"])
       query[answ]=True
    else:
        #config["fields"][i]["temp"]= input(config["fields"][i]["ask"])
        query[i]= input(config["fields"][i]["ask"])

for i in config["files"]:
    temp_file = open("template/"+i, "r")
    outfile = pystache.render(temp_file.read(), query)
    #print(outfile)
    temp_file.close()
    temp_file = open("template/"+i, "w")
    temp_file.write(outfile)

#print(config["fields"])


#print(pystache.render('Hi {{person}}!', {'person': 'Mom'}))
