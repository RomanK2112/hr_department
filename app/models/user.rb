class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many   :membership
  has_many   :groups, through: :membership
  has_many   :posts
end