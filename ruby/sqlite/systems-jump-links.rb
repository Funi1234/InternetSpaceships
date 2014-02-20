require 'sqlite3'

begin
  db = SQLite3::Database.open "/home/david/Downloads/rub110-sqlite3-v1.db"

  stm = db.prepare "SELECT * from mapsolarsystemjumps where fromSolarSystemID=30000142;"
  rs = stm.execute

  rs.each do |row|
    #puts row.inspect
    puts "From : " + row[2].to_s + " To: " + row[3].to_s
  end

rescue SQLite3::Exception => e 
    
    puts "Exception occured"
    puts e
    
ensure
    stm.close if stm
    db.close if db
end 
