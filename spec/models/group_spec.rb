require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it { should have_many(:membership) }
    it { should have_many(:users) }
    it { should have_many(:posts) }
  end
end
