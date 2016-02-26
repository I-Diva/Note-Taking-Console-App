require 'sqlite3'

begin

  db = SQLite3::Database.open "note.db"
  db.execute "CREATE TABLE IF NOT EXISTS my_notes(id INTEGER PRIMARY KEY AUTOINCREMENT, note_content TEXT);"
  
  
rescue SQLite3::Exception => e

puts "Exception occurred"
puts e

ensure
  db.close if db
end


