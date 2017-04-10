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
  answers = Array.new
  answer_correct = Answer.new title: Faker::Lorem.word, is_correct: true
  answers.push answer_correct
  3.times do |t|
    answer_incorrect = Answer.new title: Faker::Lorem.word, is_correct: false
    answers.push answer_incorrect
  end
  word = Word.create! title: Faker::Name.name, category_id: 1,
    answers_attributes: answers
end
