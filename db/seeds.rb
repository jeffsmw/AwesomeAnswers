200.times do
  Question.create({ title:      Faker::Company.catch_phrase,
                    body:       Faker::Hacker.say_something_smart,
                    view_count: rand(1000) })
end

puts "generated 200 questions"
