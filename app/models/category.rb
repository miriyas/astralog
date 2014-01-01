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
	belongs_to :parent, :class_name => "Category"
	has_many :posts, :dependent => :nullify
	has_many :categories, class_name: "Category", foreign_key: "parent_id", :dependent => :nullify

	validates_presence_of :subject_id
  validates_presence_of :name, :view_type, :if => lambda { |m| m.role == "category" }
	validates_length_of :name, :minimum => 1, :if => lambda { |m| m.role == "category" }	
  # validates_inclusion_of :style, in: %w(blog album), if: lambda { |m| m.style = "blog" if m.style.blank? }

  VIEW_TYPE = {'목록보기' => 'list', '한장보기' => 'show', '요약보기' => 'summary'}	
  ROLE = {'분류' => 'category', '구분' => 'divider', '공백' => 'spacer'}
	
	scope :upper_categories, -> {where(parent_id: nil, role: "category")}
	scope :category_roles, -> {where(role: "category")}
		
end
