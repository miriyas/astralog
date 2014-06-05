class PostDraft < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :category
  belongs_to :post

  validates_presence_of :user_id
  validates_inclusion_of :view_type, in: %w(photo normal), if: lambda { |m| m.view_type = "normal" if m.view_type.blank? }
end
