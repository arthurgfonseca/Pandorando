class Network
  include Mongoid::Document
  field :positionx, :type => Integer
  field :positiony, :type => Integer
  field :weight0, :type => Float
  field :weight1, :type => Float
  field :weight2, :type => Float
  field :weight3, :type => Float
  field :weight4, :type => Float
  field :match_count, :type => Integer, :default => 0
end
