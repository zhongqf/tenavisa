class Profile < ActiveRecord::Base
  has_many :valeurs, :dependent => :destroy
  belongs_to :educatee
  
  has_one :deny_info, :class_name => "Deny"
  
  after_save :update_elements
  
  named_scope :submitted, {:conditions => { :status => "submitted"}}
  named_scope :ordered, { :order => "updated_at desc"}
  
  include AASM
  
  aasm_column :status
  aasm_initial_state :new
  
  aasm_state :new
  aasm_state :editing
  #aasm_state :submitted
  aasm_state :frozen
  aasm_state :archived
  
  #aasm_state :accepted
  #aasm_state :denied
  
  aasm_event :start_edit do
    transitions :to => :editing, :from => [:new]
  end

  #aasm_event :submit do
  #  transitions :to => :submitted, :from => [:new, :editing], :guard => :profile_check 
  #end
  
  aasm_event :freeze do
    transitions :to => :frozen, :from => [:new, :editing]
  end
  
  aasm_event :unfreeze do
    transitions :to => :editing, :from => [:frozen]
  end
  
  aasm_event :archive do
    transitions :to => :archived, :from => [:frozen]
  end
  
  
  #aasm_event :accept do
  #  transitions :to => :accepted, :from => [:submitted]
  #end
  
  #aasm_event :deny do
  #  transitions :to => :denied, :from => [:submitted]
  #end
  
  def can_edit_by_educatee
    [:new, :denied].include?(self.aasm_current_state)
  end

  def can_edit_by_educator
    #[:new, :editing, :frozen ].include?(self.aasm_current_state)
    true
  end
  
  def title
    title_element = Element.find_by_is_title(true)
    return "(No title element defined)" if title_element.nil?
    
    title = self.send(:"#{title_element.key}") 
    
    (title.nil? || title.blank?) ? "(No title)" : title
  end
  
  
  attr_accessor :current_page_id
  
  def validate_on_update
    return if current_page_id.nil? or current_page_id.blank?
    @page = Page.find(current_page_id)
    return if @page.nil?
    
    @page.elements.each do |element|
      value = self.send(element.key)
      profile = self
      script = element.validation_script
      errors = self.errors
      
      eval(script) if script && profile
    end
  end
  
  
  
  
  Element.find(:all).each do |element|
    attr_accessor element.key.intern
  end
  attr_accessor :all_element_valeurs_loaded
  
  def after_initialize
    self.valeurs.each do |valeur|
      self.send(:"#{valeur.element_key.to_s}=", valeur.nil? ? nil : valeur.valeur )
    end
  end

  
  def update_elements
    logger.debug self.to_yaml
    
    Element.transaction do
      Element.all.each do |element|
       
        valeur = valeurs.find_or_create_by_element_id(element.id)
        valeur.element_key = element.key
        
        value = self.send(:"#{element.key}") #self.instance_variable_get("@#{element.key}")

        if value.respond_to?(:original_filename) #FIXME
          
          #TODO: image only
          #TODO: resize the image
          #TODO: big file?
                    
          if !value.original_filename.empty?
            publicpath = File.join(RAILS_ROOT, "public")
            filepath = "/upload/value/#{valeur.id}"
            filename = value.original_filename
            
            fullpath = File.join(publicpath, filepath)
            fullfilename = File.join(fullpath, filename)
            
            @savefilename = File.join(filepath, filename)

            FileUtils.remove_file(fullfilename) if File.exists?(fullfilename)
            FileUtils.mkdir_p fullpath
            
            File.open(fullfilename,"wb") do |f|
              f.write(value.read)
            end
          end  
          valeur.valeur = @savefilename
        else
          valeur.valeur = value
        end
        
        valeur.save
      end
    end
  end


end
