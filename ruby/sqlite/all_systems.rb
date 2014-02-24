require 'sqlite3'
require 'json'


def all_systems()
  begin
    system_hash = Hash.new
    db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

    stm = db.prepare "SELECT * from mapSolarSystems;"
    rs = stm.execute

    rs.each do |row|
      #puts row.inspect
      system = {
        :regionID=>row[0].to_s,
        :constellationID=>row[1].to_s,
        :solarSystemID=>row[2].to_s,
        :name=>row[3].to_s,
        :x=>"%0.2f" % (row[4] / 1.0e+15).to_s,
        :y=>"%0.2f" % (row[5] / 1.0e+15).to_s,
        :z=>"%0.2f" % (row[6] / 1.0e+15).to_s,
        :security=>row[13].to_s
      }
      system_hash[system[:solarSystemID]] = system
    end

    return system_hash.to_json

  rescue SQLite3::Exception => e 
    
    puts e
  ensure
    stm.close if stm
    db.close if db
  end
end

json = JSON.parse(all_systems())

f = File.open("../../static_dumps/eve_systems_list.json", "w")
f.write(JSON.pretty_generate(json))
f.close
