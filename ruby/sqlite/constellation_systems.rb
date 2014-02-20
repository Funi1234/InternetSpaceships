require 'sqlite3'
require 'json'


def constellation_systems(constellation_id)
  begin
    system_array = Array.new
    db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

    stm = db.prepare "SELECT * from mapSolarSystems where constellationID=#{constellation_id};"
    rs = stm.execute

    rs.each do |row|
      #puts row.inspect
      system = {
        :solar_system_id=>row[2].to_s,
        :name=>row[3].to_s,
        :x=>"%0.2f" % (row[4] / 1.0e+15).to_s,
        :y=>"%0.2f" % (row[5] / 1.0e+15).to_s,
        :z=>"%0.2f" % (row[6] / 1.0e+15).to_s,
        :security=>row[13].to_s
      }
      system_array.push(system)
    end

    return {:constellation=>constellation_id, :system_list=>system_array}.to_json

  rescue SQLite3::Exception => e 
    
    puts e
  ensure
    stm.close if stm
    db.close if db
  end
end

puts constellation_systems(20000020)
