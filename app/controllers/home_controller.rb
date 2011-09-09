class HomeController < ApplicationController
  layout 'home'
  
  def index
    
    #Init array
    arrPesos = Array.new(5)
    arrPesos[0] = 0
    arrPesos[1] = 0
    arrPesos[2] = 0
    arrPesos[3] = 0
    arrPesos[4] = 0
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
