require 'sqlite3'
require 'json'


def all_constellations()
  begin
    region_hash = Hash.new
    db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

    stm = db.prepare "SELECT * from mapRegions;"
    rs = stm.execute

    rs.each do |row|
      #puts row.inspect
      
      region = {
        :regionID=>row[0].to_s,
        :regionName=>row[1].to_s,
        :x=>"%0.2f" % (row[2] / 1.0e+15).to_s,
        :y=>"%0.2f" % (row[3] / 1.0e+15).to_s,
        :z=>"%0.2f" % (row[4] / 1.0e+15).to_s,
        :factionID=>row[11].to_s
      }
     
      region_hash[region[:regionID]] = region
    end

    return region_hash.to_json

  rescue SQLite3::Exception => e 
    
    puts e
  ensure
    stm.close if stm
    db.close if db
  end
end

json = JSON.parse(all_constellations())

f = File.open("../../static_dumps/eve_region_list.json", "w")
f.write(JSON.pretty_generate(json))
f.close
