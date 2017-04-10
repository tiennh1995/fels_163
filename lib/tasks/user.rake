namespace :db do
  desc "Import User"
  task users: [:environment] do
    20.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@gmail.com"
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
  end
end
