class Valeur < ActiveRecord::Base
  belongs_to :profile
  belongs_to :element
end
