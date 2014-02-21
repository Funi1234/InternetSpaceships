require 'json'
require "./systems_jump_links"

f = File.open("../../static_dumps/eve_systems_list.json", "r")
systems = JSON.parse(f.read)
f.close

jumps_hash = Hash.new

systems.each do |key, val|
  jumps_hash[key] = JSON.parse(solar_system_jumps(key))[key]
end

g = File.open("../../static_dumps/eve_systems_jump_list.json", "w")
g.write(JSON.pretty_generate(jumps_hash))
g.close
