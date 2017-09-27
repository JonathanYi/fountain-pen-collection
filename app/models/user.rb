class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password

  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
end
