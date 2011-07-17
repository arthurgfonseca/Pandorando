class HomeController < ApplicationController
  layout 'home'
  
  def index
    
    #Init array
    arrPesos = Array.new(2)
    arrPesos[0] = 0
    arrPesos[1] = 0
    session[:arrPesos] = arrPesos
    
    @questions = generateQuestion()
    @questionNumber = 0
   
    
  end
  
  def nextQuestion
    
    self.index()
    
  end
  
  
  private
  
  def generateQuestion
    
    questions = GenerateQuestionController.getQuestions()
    
    return questions
    
  end
  

end
