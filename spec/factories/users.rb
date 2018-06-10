FactoryBot.define do
  factory :user do
    first_name	{ Faker::Name.first_name }
    last_name	  { Faker::Name.last_name }
    email       { Faker::Internet.email }
    is_admin    { false }
    password    { Faker::Internet.password }

    factory :invalid_params do
      email nil
    end

    factory :admin do
      is_admin true
    end
  end
end
