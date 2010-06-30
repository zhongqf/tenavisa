class Educatee < ActiveRecord::Base
  has_one :account, :as => :loginable, :dependent => :destroy
  has_one :profile, :dependent=> :destroy
  
  after_create :create_my_profile
  
  protected
    def create_my_profile
      self.create_profile
    end
end
