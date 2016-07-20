FactoryGirl.define do
  factory :user do
    name {"tiennh"}
    email {Faker::Internet.email}
    password {"12345678"}
    password_confirmation {"12345678"}
    is_admin false
  end
end
