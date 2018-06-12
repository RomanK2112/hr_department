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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:membership) }
    it { should have_many(:groups).through(:membership) }
    it { should have_many(:posts) }
  end

  describe '.name' do
    it 'should return full name of user' do
      user = FactoryBot.create(:user)
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
