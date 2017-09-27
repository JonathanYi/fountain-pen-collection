class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :collections
  has_many :pens, through: :collections
  has_many :inks, through: :pens

  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
end
