require 'sqlite3'

begin
  db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

  stm = db.prepare "SELECT * from mapsolarsystems where constellationID=20000020;"
  rs = stm.execute

  rs.each do |row|
    #puts row.inspect
    puts "Constellation: " + row[1].to_s + " SolarSystemID: " + row[2].to_s + " Name: " + row[3].to_s + " X: " + "%4.2f" % (row[4] / 1.0e+15).to_s + 
    " Y: " + "%4.2f" % (row[5] / 1.0e+15).to_s + " Z: " + "%4.2f" % (row[6] / 1.0e+15).to_s + " Sec Status: " + row[13].to_s
  end

rescue SQLite3::Exception => e 
    
    puts "Exception occured"
    puts e
    
ensure
    stm.close if stm
    db.close if db
end 
