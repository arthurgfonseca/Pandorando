class Respostum < ActiveRecord::Base
  
  attr_accessible :enuciado
  validates_presence_of :enuciado
  
end
