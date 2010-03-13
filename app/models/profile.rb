class Profile < ActiveRecord::Base
  has_many :valeurs
  belongs_to :educatee
  
  after_save :update_elements
  
  
  include AASM
  
  aasm_column :status
  aasm_initial_state :new
  aasm_state :new
  aasm_state :editing
  aasm_state :submitted
  aasm_state :accepted
  aasm_state :denied
  
  Element.find(:all).each do |element|
    attr_writer element.key.intern
  end
  
  def update_elements
    Element.transaction do 
      Element.find(:all).each do |element|
        valeur = valeurs.find_or_create_by_element_id(element.id)
        valeur.element_key = element.key
        valeur.valeur = self.instance_variable_get("@#{element.key}")
        valeur.save
      end
    end
  end

  def method_missing(method_id, *arg)    
    @element_keys ||= Element.find(:all).collect(&:key)
    if (@element_keys.include?(method_id.to_s))
      loaded = self.instance_variable_get("@element_#{method_id.to_s}_loaded")
      unless loaded
        valeur = self.valeurs.find_by_element_key(method_id.to_s)
        self.instance_variable_set("@#{method_id.to_s}", valeur.nil? ? nil : valeur.valeur)
        self.instance_variable_set("@element_#{method_id.to_s}_loaded", true)
      end
      return self.instance_variable_get("@#{method_id.to_s}")
    end
    super
  end
end
