# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "12345678"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end

users = User.all
user  = users.first
following = users[2..20]
followers = users[3..10]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

10.times do |n|
  name = Faker::Name.first_name
  Category.create! name: name, created_at: Time.zone.now
end

20.times do |n|
  title = Faker::Name.name
  word = Word.create! title: title, category_id: 1
  word_id = word.id
  answer_correct = Faker::Lorem.word
  Answer.create! title: answer_correct, is_correct: true, word_id: word_id
  3.times do |t|
    answer_incorrect = Faker::Lorem.word
    Answer.create! title: answer_incorrect, is_correct: false, word_id: word_id
  end
end
