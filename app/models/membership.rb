class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, uniqueness: true
end
