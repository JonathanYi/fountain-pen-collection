class Pen < ActiveRecord::Base
  belongs_to :collection
  belongs_to :ink
end
