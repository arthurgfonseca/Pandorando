class Perfil
  include Mongoid::Document
  field :title, :type => String
  field :positionx, :type => Integer
  field :positiony, :type => Integer
  field :match_count, :type => Integer, :default => 1
  field :radius, :type => Float
  has_and_belongs_to_many :gifts
  
end
