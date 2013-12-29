# == Schema Information
#
# Table name: users
#
#  id                           :integer(4)      not null, primary key
#  email                        :string(255)     not null
#  crypted_password             :string(255)     not null
#  salt                         :string(255)     not null
#  nickname                     :string(255)
#  role                         :string(255)     default("user")
#  posts_count                  :integer(4)
#  comments_count               :integer(4)
#  created_at                   :datetime
#  updated_at                   :datetime
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!
	# has_many :authentications, :dependent => :destroy 

  validates_presence_of :email
  validates_uniqueness_of :email
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, length: { minimum: 4 }, :if => :password_required?
  validates :password, confirmation: true, :if => :password_required?
  validates :password_confirmation, presence: true, :if => :password_required?
  validates_presence_of :nickname
  validates_inclusion_of :role, :in => %w(admin user), :if => lambda { |m| m.role = "user" if m.role.blank? }

	# ROLES = {
	# 	"관리자" => "admin",
	# 	"추종자" => "user" 
	# }

	scope :users, -> { where(role: "user") }

  def password_required?
    new_record? || password
  end

  def admin?
    role == "admin"
  end

	# def user?
	# 	role == "user"
	# end
  
  # def new_password!
  #   _password = "#{SecureRandom.hex(4)}!"
  #   update_attribute :password, _password
  #   _password
  # end

end
