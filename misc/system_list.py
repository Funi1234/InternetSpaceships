####################################################################################################
# @author Dylan Conway https://github.com/Funi1234/InternetSpaceships
# @description Queries the Eve Online API and compiles a list of systemID to system name mappings
#
# @date 2013-07-30
####################################################################################################

import lxml
import json
import urllib
from lxml import etree

print "starting"

# Get the XML from API
#tmpresponce = urllib.urlopen("https://api.eveonline.com/map/Sovereignty.xml.aspx")

#XML To String
#resString = tmpresponce.read()

# Create XML Parser.
parser = etree.XMLParser(remove_blank_text=True)
# Parse String into XML Object
responce = etree.XML(urllib.urlopen("https://api.eveonline.com/map/Sovereignty.xml.aspx").read(), parser)



systemIDMap = {}

# Get the array of rows, the rowset element
rows = responce.xpath("//rowset")

#iterate through the rows
for row in rows[0]:
    systemIDMap[row.get("solarSystemID")] = row.get("solarSystemName")
    

# Print the system name for that ID
print systemIDMap["30000142"]

# Print the ID for that system name
for sysid, sys in systemIDMap.iteritems():
    if sys.startswith("Jita") > 0:
        print sysid

        
#print etree.tostring(responce, pretty_print=True)
