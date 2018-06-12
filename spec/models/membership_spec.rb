# == Schema Information
#
# Table name: memberships
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  group_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:group) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:group_id) }
  end
end
