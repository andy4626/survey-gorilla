require 'faker'

20.times{|i| User.create(username: Faker::Internet.user_name, password: "a")}

20.times{|i| Survey.create(name: Faker::Hacker.noun, user_id: i+1)}

20.times{|i| Question.create(content: Faker::Lorem.sentence(2, false).gsub('.','?'), survey_id: i + 1)}

20.times do |i|
  2.times{|c| Answer.create(content: Faker::Lorem.sentence(2, false), question_id: i +1)}
end

20.times{|i| UserAnswer.create(user_id: i + 1, answer_id: i + 1)}
