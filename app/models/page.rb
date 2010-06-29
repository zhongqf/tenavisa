class Page < ActiveRecord::Base
  has_many :elements, :dependent => :destroy, :order => "weight"
  
  def typus_name
    self.title
  end
  
end
