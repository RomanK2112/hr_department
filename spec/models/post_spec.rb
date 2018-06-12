# == Schema Information
#
# Table name: posts
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  group_id   :uuid
#  title      :string
#  body       :text
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:group) }
  end
end
