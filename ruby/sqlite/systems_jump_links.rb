require 'sqlite3'
require 'json'



def solar_system_jumps(solar_system_id)
  begin
    system_jumps_hash = Hash.new
    jumps_array = Array.new
    db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

    stm = db.prepare "SELECT * from mapsolarsystemjumps where fromSolarSystemID=#{solar_system_id};"
    rs = stm.execute

    rs.each do |row|
      #puts row.inspect
       jumps_array.push(row[3].to_s)
    end
    
    system_jumps_hash[solar_system_id] = jumps_array
    
    return system_jumps_hash.to_json

  rescue SQLite3::Exception => e 
	    
    puts e
  ensure
    stm.close if stm
    db.close if db
  end 
end

puts solar_system_jumps("30000142")
