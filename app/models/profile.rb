class Profile < ActiveRecord::Base
  has_many :values
  
  include AASM
  
  aasm_column :status
  aasm_initial_state :new
  aasm_state :editing
  aasm_state :registered
  aasm_state :accepted
  aasm_state :denied
end
