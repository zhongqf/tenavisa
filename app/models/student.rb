class Student < ActiveRecord::Base
  has_one :account, :as => :loginable
  has_one :profile
end
