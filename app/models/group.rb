# == Schema Information
#
# Table name: groups
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Group < ApplicationRecord
  has_many :membership
  has_many :users, through: :membership
  has_many :posts

  scope :filter_groups, ->(group) { where(id: group) }
end
