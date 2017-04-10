namespace :db do
  desc "Import Category"
  task categories: [:environment] do
    10.times do |n|
      name = Faker::Name.first_name
      Category.create! name: name, created_at: Time.zone.now
    end
  end
end
