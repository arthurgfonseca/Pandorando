class Answer
  include Mongoid::Document
  field :enunciation, :type => String
  
  belongs_to :question
  has_many :characteristics
  
end
