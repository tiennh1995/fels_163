FactoryGirl.define do
  factory :word do
    title {Faker::Name.name}
  end
end
