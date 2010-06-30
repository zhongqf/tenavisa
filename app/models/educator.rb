class Educator < ActiveRecord::Base
  has_one :account, :as => :loginable, :dependent => :destroy
  
  def operator?
    self.is_operator
  end
end
