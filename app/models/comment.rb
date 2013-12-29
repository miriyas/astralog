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
	belongs_to :post, :counter_cache => true, touch: true
	belongs_to :user, :counter_cache => true, touch: true
	belongs_to :comment
	has_one :comment, :dependent => :nullify
end
