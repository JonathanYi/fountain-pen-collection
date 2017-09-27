class Ink < ActiveRecord::Base
  has_many :pens
  has_many :collections, through: :pens
  has_many :users, through: :collections

  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
end
