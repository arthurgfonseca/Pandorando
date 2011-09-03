class Respostum
  include Mongoid::Document
  
  attr_accessible :enuciado
  validates_presence_of :enuciado
  
end
