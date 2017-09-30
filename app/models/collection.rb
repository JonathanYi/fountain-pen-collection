class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :pens
  has_many :inks, through: :pens

  include Slugifiable::InstanceMethodName
  extend Slugifiable::ClassMethod
end
