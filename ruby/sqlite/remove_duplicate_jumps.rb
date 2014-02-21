require 'json'

f = File.open("../../static_dumps/eve_systems_jump_list.json", "r")
jumps = JSON.parse(f.read)
f.close

jump_list = Array.new

jumps.each do |key, i|
  i.each do |j|
    jump_list.push([key, j])
  end
end


jump_list.each do |i|
  jump_list.delete(i.reverse)
end

g = File.open("../../static_dumps/eve_systems_jump_list_minus_duplicates.json", "w")
g.write(JSON.pretty_generate(jump_list))
g.close
