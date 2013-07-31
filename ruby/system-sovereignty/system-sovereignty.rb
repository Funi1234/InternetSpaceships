####################################################################################################
# @author David Kirwan https://github.com/davidkirwan/ardtweeno
# @description Queries the Eve Online API and retrieves information about system sovereignty
#
# @APIURI https://api.eveonline.com/map/Sovereignty.xml.aspx
#
# @date 2013-07-31
####################################################################################################

require 'json'
require 'nokogiri'
require 'open-uri'

systemlist = Array.new

sov = Nokogiri::HTML(open("https://api.eveonline.com/map/Sovereignty.xml.aspx"))

rows = sov.xpath("//row")

rows.each do |r|
  key = r.attr("solarsystemid")
  val = r.attr("solarsystemname")
  faction = r.attr("factionid")
  alliance = r.attr("allianceid")

  hash = Hash.new

  hash[key] = val
  if alliance == "0" then hash["faction"] = "Empire"; else hash["faction"] = alliance; end

  systemlist << hash
end

puts systemlist.to_json

