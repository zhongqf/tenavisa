class Element < ActiveRecord::Base
  belongs_to :page
  
  #KIND = %w(boolean date datetime file password rich_text radio selector string text time)
  KIND = %w(boolean date file radio selector string text)
  validates_inclusion_of :kind, :in => KIND
  
end
