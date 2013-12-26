# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  post_id    :integer(4)
#  body       :text
#  user_ip    :string(255)
#  type       :string(255)
#  parent_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
end
