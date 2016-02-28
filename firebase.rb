require 'firebase'
require 'json'
# data = File.read('src/quiz_questions.json')
# questions = JSON.parse(data)

# data = File.read('src/quest.json')
# Eng = JSON.parse(data)

base_uri = 'https://quiz-application.firebaseio.com/'

firebase = Firebase::Client.new(base_uri)

# response = firebase.push("eng-quiz", Eng)
# response.success? # => true
# response.code # => 200
# response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
# response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'
response=firebase.get("quiz")
c=response.body
puts c.class
  c.each do |key, value|
  puts key
  value.each do |k,v|
    puts k
    puts v
  end
end