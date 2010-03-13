class Element < ActiveRecord::Base
  belongs_to :page
  
  KIND = %w(boolean date datetime file password rich_text selector string text time)
  validates_inclusion_of :kind, :in => KIND
  
end
