class Profile < ActiveRecord::Base
  has_many :valeurs
  belongs_to :educatee
  
  after_save :update_elements
  
  include AASM
  
  aasm_column :status
  aasm_initial_state :new
  aasm_state :new
  aasm_state :submitted
  aasm_state :accepted
  aasm_state :denied
  
  aasm_event :submit do
    transitions :to => :submitted, :from => [:new, :editing], :guard => :profile_check 
  end
  
  aasm_event :accept do
    transitions :to => :accepted, :from => [:submitted]
  end
  
  aasm_event :deny do
    transitions :to => :denied, :from => [:submitted]
  end
  
  def can_edit_by_educatee
    [:new, :denied].include?(self.aasm_current_state)
  end
  
  def profile_check
    true
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
            filename = value.original_filename
            fullpath = "#{RAILS_ROOT}/public/upload/value/#{valeur.id}/"
            @fullname = "#{fullpath}#{filename}"
            
            FileUtils.remove_file(@fullname) if File.exists?(@fullname)
            FileUtils.mkdir_p fullpath
            
            File.open(@fullname,"wb") do |f|
              f.write(value.read)
            end
          end  
          valeur.valeur = @fullname
        else
          valeur.valeur = value
        end
        
        valeur.save        
      end
    end
  end


end
