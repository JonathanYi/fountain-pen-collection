class Pen < ActiveRecord::Base
  belongs_to :collection
  belongs_to :ink

  include Slugifiable::InstanceMethodName
  extend Slugifiable::ClassMethod
end
