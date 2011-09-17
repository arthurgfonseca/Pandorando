class Produto
  include Mongoid::Document
  field :field1, :type => String
  field :field2, :type => String
  field :fields, :type => Integer
  
end
