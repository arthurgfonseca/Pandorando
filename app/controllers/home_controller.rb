include ActionView::Helpers::SanitizeHelper 

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
  
  def getGifts
    
    # puts "get products"
    # produtos = Produto.all
    # 
    # for produto in produtos
    #   gift = Gift.new
    #   gift.name = strip_tags(produto.field1)
    #   gift.price = (produto.field2).to_s
    #   gift.save
    # end
    
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
    
    puts "GET USER"
    
    name = params[:nome]
    email = params[:email]
    @findUser = false
    
    user = User.where(:email => email).first
    
    puts "USERRRRR"
    puts user
    puts "fimm"
    @questions = generateQuestion()
    @questionNumber = 0
    
    if(user)
      session[:user] = (user.email).to_s
      
      puts 'hahahaha'
      puts session[:user]
      
      @findUser = true
    else
      @findUser = false
    end
    
  end
  
  def createUser
    
    puts "CREATE USER"
    
    name = params[:nome]
    email = params[:email]
    
    user = User.new
    user.name = name
    user.email = email
    
    if(user.save)    
      session[:user] = (user.email).to_s
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
