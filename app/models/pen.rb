class Pen < ActiveRecord::Base
  belongs_to :collection
  belongs_to :ink
  belongs_to :user

  include Slugifiable::InstanceMethodName
  extend Slugifiable::ClassMethod
end
