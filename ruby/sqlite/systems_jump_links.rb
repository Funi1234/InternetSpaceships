require 'sqlite3'
require 'json'



def solar_system_jumps(solar_system_id)
  begin
    system_array = Array.new
    db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

    stm = db.prepare "SELECT * from mapsolarsystemjumps where fromSolarSystemID=#{solar_system_id};"
    rs = stm.execute

    rs.each do |row|
      #puts row.inspect
      system_array.push(row[3].to_s)
    end

    return {:solarSystemID=>solar_system_id,:gate=>system_array}.to_json

  rescue SQLite3::Exception => e 
	    
    puts e
  ensure
    stm.close if stm
    db.close if db
  end 
end


def clean_duplicate_gate_jumps(solar_system_id)
  
  
end


gate_list_system = "30000142"

puts "Retrieving the gates attached to: #{gate_list_system}\n\n"
json = solar_system_jumps(gate_list_system)
jita = JSON.parse(json)

test = Array.new

jita["gate"].each do |i|
  puts i
  system = solar_system_jumps(i)
  parsedSystem = JSON.parse(system)
  parsedSystem["gate"].delete(gate_list_system)
  parsedSystem["gate"]
end
