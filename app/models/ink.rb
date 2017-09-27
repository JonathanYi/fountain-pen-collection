class Ink < ActiveRecord::Base
  has_many :pens
  has_many :collections, through: :pens

  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
end
