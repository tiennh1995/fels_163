require "faker"

FactoryGirl.define do
  factory :answer do
    title {Faker::Name.name}
    is_correct true
  end
end
