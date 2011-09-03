class Characteristic
  include Mongoid::Document
  field :title, :type => String
  field :load, :type => Integer
  
  belongs_to :answer
  
end
