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
    attr_writer element.key.intern
  end
  
  def method_missing(method_id, *arg)
    @element_keys ||= Element.all.collect(&:key)
    
    if (@element_keys.include?(method_id.to_s))
      loaded = self.instance_variable_get("@all_element_valeurs_loaded")
      unless loaded
        logger.debug "====== load element valeurs ======"
        self.valeurs.each do |valeur|
          self.instance_variable_set("@#{valeur.element_key.to_s}", valeur.nil? ? nil : valeur.valeur )
        end
        self.instance_variable_set("@all_element_valeurs_loaded", true)
      end
      return self.instance_variable_get("@#{method_id.to_s}")
    end
    super
  end
  
  def update_elements
    Element.transaction do
      Element.all.each do |element|
        logger.debug "====== updating #{element.key} ======"
        valeur = valeurs.find_or_create_by_element_id(element.id)
        valeur.element_key = element.key
        valeur.valeur = self.instance_variable_get("@#{element.key}")
        loaded = self.instance_variable_get("@all_element_valeurs_loaded")
        valeur.save #if loaded        
      end
    end
  end
  
  #def update_elements
  #  Element.transaction do 
  #    Element.find(:all).each do |element|
  #      valeur = valeurs.find_or_create_by_element_id(element.id)
  #      valeur.element_key = element.key
  #      valeur.valeur = self.instance_variable_get("@#{element.key}")
  #      loaded = self.instance_variable_get("@element_#{element.key}_loaded")
  #      valeur.save if loaded
  #    end
  #  end
  #end
  #
  #def method_missing(method_id, *arg)    
  #  @element_keys ||= Element.find(:all).collect(&:key)
  #  if (@element_keys.include?(method_id.to_s))
  #    loaded = self.instance_variable_get("@element_#{method_id.to_s}_loaded")
  #    unless loaded
  #      logger.debug "loading #{method_id}"
  #      valeur = self.valeurs.find_by_element_key(method_id.to_s)
  #      self.instance_variable_set("@#{method_id.to_s}", valeur.nil? ? nil : valeur.valeur)
  #      self.instance_variable_set("@element_#{method_id.to_s}_loaded", true)
  #    end
  #    return self.instance_variable_get("@#{method_id.to_s}")
  #  end
  #  super
  #end
end
