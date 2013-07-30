import lxml
import json
import urllib
from lxml import etree

tmpresponce = urllib.urlopen("https://api.eveonline.com/map/Sovereignty.xml.aspx")

resString = tmpresponce.read()

#print type(resString)


parser = etree.XMLParser(remove_blank_text=True)

responce = etree.XML(resString, parser)

print "starting"

systemIDMap = {}

# Get the array of rows, the rowset element
rows = responce.xpath("//rowset")

#iterate through the rows
for row in rows[0]:
    systemIDMap[row.get("solarSystemID")] = row.get("solarSystemName")
    


print systemIDMap["30002768"]
#print etree.tostring(responce, pretty_print=True)
