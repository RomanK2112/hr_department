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
