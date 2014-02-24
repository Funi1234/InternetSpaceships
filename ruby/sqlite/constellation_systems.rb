require 'sqlite3'
require 'json'


def constellation_systems(constellation_id)
  begin
    constellation_hash = Hash.new
    system_array = Array.new
    db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

    stm = db.prepare "SELECT * from mapSolarSystems where constellationID=#{constellation_id};"
    rs = stm.execute

    rs.each do |row|
      #puts row.inspect
      system_array.push(row[2].to_s)
    end
    
    
    constellation_hash[constellation_id] = system_array
    return constellation_hash.to_json

  rescue SQLite3::Exception => e 
    
    puts e
  ensure
    stm.close if stm
    db.close if db
  end
end

puts constellation_systems("20000020")
