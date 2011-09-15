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
    
    @train_mode = Constants::TRAIN_MODE
    @questions = generateQuestion()
    @questionNumber = 0
       
    
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
    
    name = params[:nome]
    email = params[:email]
    
    user = User.new
    user.name = name
    user.email = email
    
    if(user.save)    
      
      @questions = generateQuestion()
      @questionNumber = 0
      
      respond_to do |format|
        format.html # new.html.erb
        format.js # Ajax CRUD
      end
    end
    
  end
  
  
  private
  
  def generateQuestion
    
    questions = GenerateQuestionController.getQuestions()
    
    return questions
    
  end
  

end
