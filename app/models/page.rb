class Page < ActiveRecord::Base
  has_many :elements, :dependent => :destroy
  
  def typus_name
    self.title
  end
  
end
