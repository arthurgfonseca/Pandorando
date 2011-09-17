class Gift
  include Mongoid::Document
  field :name, :type => String
  field :price, :type => String
  field :rating, :type => Integer, :default => 0
  
  has_and_belongs_to_many :perfils
  
end