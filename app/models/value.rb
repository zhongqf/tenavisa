class Value < ActiveRecord::Base
  belongs_to :profile
  belongs_to :element
end
