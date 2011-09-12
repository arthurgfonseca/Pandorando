class Perfil
  include Mongoid::Document
  field :title, :type => String
  field :positionx, :type => Integer
  field :positiony, :type => Integer
  has_and_belongs_to_many :gifts
  
end
