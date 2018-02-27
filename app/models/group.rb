class Group < ApplicationRecord
  has_many :membership
  has_many :users, through: :membership
  has_many :posts

  scope :filter_groups, ->(group) { where(id: group) }
end
