class Operator < ActiveRecord::Base
  has_one :account, :as => :loginable, :dependent => :destroy
end
