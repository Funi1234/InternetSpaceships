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

print "starting"

data = urllib.urlencode({'version':'2'})
#data = urllib.urlencode({'corporationID':'1018389948'})

#Dreddit ID: 1018389948

# Get the XML from API
tmpresponce = urllib.urlopen("https://api.eveonline.com/eve/AllianceList.xml.aspx", data)

#tmpresponce = urllib.urlopen("https://api.eveonline.com/corp/CorporationSheet.xml.aspx", data)

#XML To String
resString = tmpresponce.read()

# Create XML Parser.
parser = etree.XMLParser(remove_blank_text=True)

# Parse String into XML Object
responce = etree.XML(resString, parser)



#systemIDMap = {}

#Get the array of rows, the rowset element
all = responce.xpath("//rowset")

#print all

#iterate through the rows
for results in all:
    for row in results:
        for corp in row[0]:
            print corp.attrib
    


        


#print etree.tostring(responce, pretty_print=True)
