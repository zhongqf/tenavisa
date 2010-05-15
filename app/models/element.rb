class Element < ActiveRecord::Base
  belongs_to :page
  
  #KIND = %w(boolean date datetime file password rich_text radio selector string text time)
  KIND = %w(boolean date file radio selector string text multicheck)
  validates_inclusion_of :kind, :in => KIND
  
  
  named_scope :display_columns, { :conditions => ["display_index > 0 or is_title = ?", true], :order => "is_title desc, display_index" }
end
