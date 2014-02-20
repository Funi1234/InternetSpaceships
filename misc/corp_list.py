####################################################################################################
# @author Dylan Conway https://github.com/Funi1234/InternetSpaceships
# @description Queries the Eve Online API and compiles a list of cropID to Corp name mappings
#
# @date 2013-07-30
####################################################################################################

import lxml
import json
import urllib
from lxml import etree
import json

print "starting"
CorpIDMap = {}

#output=open("CorpIDMap.txt","w+")

data = urllib.urlencode({'version':'2'})
#data = urllib.urlencode({'corporationID':'1018389948'})

#Dreddit ID: 1018389948

# Get the XML from API
#tmpresponce = urllib.urlopen("https://api.eveonline.com/eve/AllianceList.xml.aspx", data)
tmpresponce = urllib.urlopen("https://api.testeveonline.com/eve/AllianceList.xml.aspx", data)
#tmpresponce = urllib.urlopen("https://api.eveonline.com/corp/CorporationSheet.xml.aspx", data)

#XML To String
resString = tmpresponce.read()

# Create XML Parser.
parser = etree.XMLParser(remove_blank_text=True)

# Parse String into XML Object
responce = etree.XML(resString, parser)



#systemIDMap = {}

#Get the array of rows,
all = responce.xpath("//row")

#output.write("{\n")
#print all
x = 0
for row in all:
#for x in range(0,10):
    #row = all[x]
    if row.get("corporationID") != None:
        x = x + 1
        if x % 10 == 0:
            print x
        #print row.attrib
        data = urllib.urlencode({'corporationID':row.get("corporationID")})
        print ("ID: "+row.get("corporationID"))
        #corp = etree.XML(urllib.urlopen("https://api.eveonline.com/corp/CorporationSheet.xml.aspx", data).read(), parser)
        corp = etree.XML(urllib.urlopen("https://api.testeveonline.com/corp/CorporationSheet.xml.aspx", data).read(), parser)
        CorpIDMap[row.get("corporationID")] = corp.xpath("//corporationName")[0].text
        #output.write("{"+row.get("corporationID")+":"+corp.xpath("//corporationName")[0].text+"}\n")
        print("{"+row.get("corporationID")+":"+corp.xpath("//corporationName")[0].text+"}\n")

#print json.dumps(CorpIDMap)#["1018389948"]

#tmp = json.dumps(CorpIDMap, indent=4, sort_keys=True)

#output.write(json.dumps(CorpIDMap, indent=4, sort_keys=True))
#output.writeline("}")
#output.close()

###iterate through the rows
##for results in all:
##    for row in results:
##        for corp in row[0]:
##            print corp.attrib
##    
##

        


#print etree.tostring(responce, pretty_print=True)
