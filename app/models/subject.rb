# == Schema Information
#
# Table name: subjects
#
#  id               :integer(4)      not null, primary key
#  style            :string(255)
#  name             :string(255)
#  categories_count :integer(4)
#  posts_count      :integer(4)
#  view_count       :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

class Subject < ActiveRecord::Base
	has_many :categories, :dependent => :nullify
	has_many :posts, :dependent => :nullify

	validates_presence_of :name
	validates_length_of :name, minimum: 1, message: "주제명은 반드시 1글자 이상이어야 합니다."
  validates_inclusion_of :style, in: %w(blog album), if: lambda { |m| m.style = "blog" if m.style.blank? }
	
  STYLES = {'블로그' => 'blog', '앨범' => 'album'}
	
end
