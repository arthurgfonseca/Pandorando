class History
  include Mongoid::Document
  field :internal_id, :type => Integer
  field :weight0, :type => Float
  field :weight1, :type => Float
  field :weight2, :type => Float
  field :weight3, :type => Float
  field :weight4, :type => Float
end
