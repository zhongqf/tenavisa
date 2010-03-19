class Educator < ActiveRecord::Base
  has_one :account, :as => :loginable
  
  def operator?
    self.is_operator
  end
end
