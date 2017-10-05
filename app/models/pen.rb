class Pen < ActiveRecord::Base
  belongs_to :collection
  belongs_to :ink
  has_one :user, through: :collection

  include Slugifiable::InstanceMethodName
  extend Slugifiable::ClassMethod
end
