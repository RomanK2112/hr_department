# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  first_name             :string
#  last_name              :string
#  is_admin               :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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

    after(:create) do |user|
      user.groups << FactoryBot.create(:group)
    end
  end
end
