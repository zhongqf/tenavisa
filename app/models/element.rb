class Element < ActiveRecord::Base
  belongs_to :page
  
  has_many :valeurs, :dependent => :destroy
  
  validates_uniqueness_of :key
  validates_presence_of :key
  
  #KIND = %w(boolean date datetime file password rich_text radio selector string text time)
  KIND = %w(boolean date file radio selector string text multicheck)
  validates_inclusion_of :kind, :in => KIND
  
  
  named_scope :display_columns, { :conditions => ["display_index > 0 or is_title = ?", true], :order => "is_title desc, display_index" }
  
  def typus_name
    self.key
  end
end
