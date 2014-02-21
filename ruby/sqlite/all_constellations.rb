require 'sqlite3'
require 'json'


def all_constellations()
  begin
    constellation_hash = Hash.new
    db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

    stm = db.prepare "SELECT * from mapConstellations;"
    rs = stm.execute

    rs.each do |row|
      #puts row.inspect
      
      constellation = {
        :regionID=>row[0].to_s,
        :constellationID=>row[1].to_s,
        :constellationName=>row[2].to_s,
        :x=>"%0.2f" % (row[3] / 1.0e+15).to_s,
        :y=>"%0.2f" % (row[4] / 1.0e+15).to_s,
        :z=>"%0.2f" % (row[5] / 1.0e+15).to_s,
        :factionID=>row[12].to_s
      }
      
      constellation_hash[constellation[:constellationID]] = constellation
    end

    return constellation_hash.to_json

  rescue SQLite3::Exception => e 
    
    puts e
  ensure
    stm.close if stm
    db.close if db
  end
end

json = JSON.parse(all_constellations())

f = File.open("../../static_dumps/eve_constellation_list.json", "w")
f.write(JSON.pretty_generate(json))
f.close
