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
    puts "QUESTION SIZE"
    puts @questions.size
   
    
  end
  
  def nextQuestion
    
    self.index()
    
  end
  
  def getUserAnswer
    
    @userAnswer = params[:id]
    
    puts "USER ANSWER"
    puts @userAnswer
    
    respond_to do |format|
      format.html # new.html.erb
      format.js # Ajax CRUD
    end
    
  end
  
  def getUser
    
    
    
  end
  
  def createUser
    
    puts "CREATE USER"
    
    respond_to do |format|
      format.html # new.html.erb
      format.js # Ajax CRUD
    end
    
  end
  
  
  private
  
  def generateQuestion
    
    questions = GenerateQuestionController.getQuestions()
    
    return questions
    
  end
  

end
