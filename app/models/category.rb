# == Schema Information
#
# Table name: categories
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  subject_id  :integer(4)
#  parent_id   :integer(4)
#  view_type   :string(255)
#  posts_count :string(255)
#  position    :integer(4)
#  role        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Category < ActiveRecord::Base
	belongs_to :subject
	belongs_to :category
	has_many :posts, :dependent => :nullify
	has_many :categories, :dependent => :nullify

	validates_presence_of :name, :subject_id, :view_type
	validates_length_of :name, :minimum => 1	
end
