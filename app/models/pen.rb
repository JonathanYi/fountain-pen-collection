class Pen < ActiveRecord::Base
  belongs_to :collection
  belongs_to :ink

  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
end
