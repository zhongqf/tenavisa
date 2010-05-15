class Deny < ActiveRecord::Base
  belongs_to :profile
  belongs_to :educator
  
  validates_presence_of :reason
end
