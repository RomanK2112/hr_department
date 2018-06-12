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

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates_uniqueness_of :user_id, scope: :group_id
end
