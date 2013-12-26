# == Schema Information
#
# Table name: themes
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  posts_count :integer(4)
#  view_count  :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Theme < ActiveRecord::Base
end
