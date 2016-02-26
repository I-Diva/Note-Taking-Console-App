require 'firebase'
require 'sqlite3'
$db = SQLite3::Database.open "note.db"
module Olayemi
  # create a class note-taking application that uses modules for namespacing
  URL = 'https://glowing-heat-3222.firebaseio.com/'
  class NotesApplication
    attr_reader :name, :notes

    def initialize(author)
      error_handler author
      @name = author
      @notes = $db.execute("SELECT * FROM my_notes")
    end

    def create(note_content)
      check_note_input note_content
      sql = "INSERT INTO my_notes (`note_content`) VALUES ('#{note_content}')"
	  $db.execute(sql)
	  
    end

    def get(note_id)
      check_note_id note_id
      @notes[note_id]
    end

    def list
      return [] if @notes.empty?
	  @notes = $db.execute("SELECT * FROM my_notes")
	  array = []
	  for row in @notes
		array << "Note ID: #{row[0]}\n #{row[1]}\n\nBy Author #{@name}\n\n"
      end
	  array
      
    end

    def edit(note_id, new_content)
      check_note_id note_id
      check_note_input new_content
      check_if_note_exists note_id
      @notes[note_id] = new_content
    end

    def delete(note_id)
      check_note_id note_id
      @notes.delete_at note_id
    end
	
	def export
		@notes
	end

    def search(search_text)
      check_note_input search_text
      result = {}
      @notes.each_with_index do |text, index|
        result[index] = text unless (text =~ /(#{search_text})/).nil?
      end

      if !result.empty?
        result.each { |index, text| return "Note ID: #{index}\n #{text}\n\nBy Author #{@name}\n" }
        return "No notes found for the search: #{search_text}"
      end
    end

    private

    def check_if_note_exists(note_id)
      return 'Note does not exist' if @notes[note_id].nil?
      nil
    end

    def check_note_input(note)
      raise 'Input should be a string' unless note.is_a? String
      nil
    end

    def check_note_id(note_id)
      raise 'Note Id must be an Integer' unless note_id.is_a? Integer
      nil
    end

    def error_handler(author)
      raise 'Input should be a string' unless author.is_a? String
      raise 'No Chars Allowed' if author =~ /[~!@#$%^&*(){}|:<>]+/
      raise 'Author name cannot be empty' if author.empty?
      raise RuntimeError if author.nil?
      nil
    end
  end
end
