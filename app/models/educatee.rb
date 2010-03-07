class Educatee < ActiveRecord::Base
  has_one :account, :as => :loginable
  has_one :profile
  
  after_create :create_my_profile
  
  protected
    def create_my_profile
      self.create_profile
    end
end
