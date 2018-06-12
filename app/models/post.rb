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

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  mount_uploader :file, FileUploader
end
