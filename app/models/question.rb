class Question
  include Mongoid::Document
  field :enunciation, :type => String
  
  has_many :answers, :dependent => :destroy
  
  validates :enunciation, :presence => true
end
