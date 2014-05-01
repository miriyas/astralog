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
  has_many :comments, class_name: "Comment", foreign_key: "parent_id", :dependent => :nullify

  validates_presence_of :user_id, :post_id, :body
  validates_length_of :body, :minimum => 1
  validates_inclusion_of :role, in: %w(comment trackback), if: lambda { |m| m.role = "comment" if m.role.blank? }
  validates_inclusion_of :status, in: %w(pending running mocking blocked), if: lambda { |m| m.status = "pending" if m.status.blank? }

  ROLE = {'댓글' => 'comment', '트랙백' => 'trackback'} 
end
