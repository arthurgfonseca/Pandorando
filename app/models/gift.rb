class Gift
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  field :rating, :type => Integer
  
  has_and_belongs_to_many :perfils
  
end
