require 'json'

f = File.open("../../static_dumps/eve_systems_jump_list.json", "r")
jumps = JSON.parse(f.read)
f.close

puts jumps.size
