require 'rubygems'
require 'json'
require 'firebase'
require 'sqlite3'
require './note_app'
include Olayemi
def start
  puts 'Please Enter the Authors name: '
  author_name = gets.chomp
  $author = NotesApplication.new author_name
  ask
end

def create
  puts 'Enter your note: '
  text = gets.chomp
  $author.create text
  ask
end

def edit
  puts 'Enter the note id: '
  note_id = gets.chomp.to_i
  puts 'Please enter the new note: '
  new_note = gets.chomp
  $author.edit note_id, new_note
  ask
end

def list
  $author.list.each {|x| print x}
  ask
end

def name
  puts $author.name
  ask
end

def delete
  puts 'Enter note id to delete: '
  note_id = gets.chomp.to_i
  print $author.delete note_id
  ask
end

def search
  puts 'Enter a word to search: '
  search = gets.chomp
  puts 'Searching...........'
  puts $author.search search

  ask
end
def export
  note_hashed = $author.export.to_h.to_json
  File::open("input.json","w+") do |f|
    f.write(note_hashed)
    f.close
  end
  ask
end

def import
	# puts $author.export.to_h.to_json
  print "MY teeth"
end

def ask
  puts
  puts 'Do you wnat to perform another action?(y/n): '
  answer = gets.chomp.downcase
  puts

  if answer == 'y'
    puts 'What do you want to do?: '
    puts 'Choose from the following: '
    puts ["\t c to create", "\t e to edit", "\t l to list", "\t d to delete", "\t s to search","\t x to export","\t i to import"]

    action = gets.chomp.downcase

  case action
  when 'c' then create
  when 'e' then edit
  when 'l' then list
  when 'd' then delete
  when 's' then search
  when 'x' then export
  when 'i' then import
    else 
	  json = File.read('input.json')
	  obj = JSON.parse(json)
	  puts obj
    end

  end
end

start
