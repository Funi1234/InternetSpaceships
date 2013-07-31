####################################################################################################
# @author David Kirwan https://github.com/davidkirwan/ardtweeno
# @description Queries the Eve Online API and retrieves information about system kills
# 
# @APIURI https://api.eveonline.com/map/Kills.xml.aspx
#
# @date 2013-07-31
####################################################################################################

require 'json'
require 'nokogiri'
require 'open-uri'
require "../system-sovereignty/system-sovereignty.rb"

def killlist()
  sovlist = sovlist()
  killlist = Array.new

  kills = Nokogiri::HTML(open("https://api.eveonline.com/map/Kills.xml.aspx"))

  rows = kills.xpath("//row")

  rows.each do |r|
    key = r.attr("solarsystemid")
    val = nil

    sovlist.each do |i|
      unless i[key].nil? then val = i[key]; end
    end

    kill = r.attr("shipkills")
    factionkills = r.attr("factionkills")
    pods = r.attr("podkills")

    hash = Hash.new

    hash[key] = val
    hash["shipkills"] = kill
    hash["factionkills"] = factionkills
    hash["podkills"] = pods

    killlist << hash
  end

  return killlist
end

