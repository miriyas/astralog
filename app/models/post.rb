# == Schema Information
#
# Table name: posts
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  subject_id         :integer(4)
#  category_id        :integer(4)
#  comments_count     :integer(4)
#  title              :string(255)
#  body               :text
#  tags               :string(255)
#  status             :string(255)
#  view_type          :string(255)
#  view_count         :integer(4)
#  main_image         :integer(4)
#  comment_permission :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Post < ActiveRecord::Base
	belongs_to :user, :counter_cache => true, touch: true
	belongs_to :subject, :counter_cache => true, touch: true
	belongs_to :category, :counter_cache => true, touch: true
	has_many :comments, :dependent => :destroy

	validates_presence_of :user_id, :subject_id, :category_id, :title, :body
	validates_length_of :title, :minimum => 1
	validates_length_of :body, :minimum => 1
end
