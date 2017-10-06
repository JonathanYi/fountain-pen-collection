class Ink < ActiveRecord::Base
  has_many :pens
  has_many :collections, through: :pens
  belongs_to :user

  include Slugifiable::InstanceMethodName
  extend Slugifiable::ClassMethod
end
