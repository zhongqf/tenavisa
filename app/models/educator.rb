class Educator < ActiveRecord::Base
  has_one :account, :as => :loginable
end