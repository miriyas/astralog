# == Schema Information
#
# Table name: posts
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  theme_id           :integer(4)
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
end
