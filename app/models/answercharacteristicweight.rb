class AnswerCharacteristicWeight
  include Mongoid::Document
  field :characteristic_id, :type => Float
  field :weight, :type => Float, :default => 0.0
  
  validates :weight, :presence => true
  
  belongs_to :answer
  
  alias :original_save :save
  def save

    pesoJaExistente = AnswerCharacteristicWeight.first(
      conditions: {
        "characteristic_id" => self.characteristic_id,
        "answer_id" => self.answer.id
      }
    )
    
    unless pesoJaExistente.nil? 
      pesoJaExistente.weight = self.weight
      pesoJaExistente.update
      return
    end
    
    return original_save
  end
  
end
