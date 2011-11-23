# encoding: utf-8
include ActionView::Helpers::SanitizeHelper 

class HomeController < ApplicationController
  layout 'home'
  
  def index
    
    
    session[:autorizado] = false
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
    
    
    @valido = true
    @erro = ""
    name = params[:nome]
    email = params[:email]
    
    if(name.to_s == "" || email.to_s == "")
       @erro = "Todos os campos devem ser preenchidos"
      @valido = false
    end
    
    if(@valido)
        if !email.match(/\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/)
          @erro = "Email inválido"
          @valido = false
        end
    end
    
    if(@valido)
      emailCadastrado = User.where(:email => email).first
      if !(emailCadastrado == nil)
        @valido = false
        @erro = "Email já cadastrado"
      end
    end
    
  
    user = User.new
    user.name = name
    user.email = email
    
    @questionNumber = 0
    @questions = generateQuestion()
  
  if(@valido)
    if(user.save)
      session[:user] = (user.email).to_s
    end
  end
  
  respond_to do |format|
    format.html # new.html.erb
    format.js # Ajax CRUD
  end
    
  end
  
  def admin
    puts "entrei aki no admin"
    respond_to do |format|
      format.html
    end
  end
  
  def authentication
    
    puts "ENTREI AUTENTICACAO"
    senha = params[:senha]
    puts "FIM senha"
    
    if senha == Constants::SENHA_PANDORANDO
      
      session[:autorizado] = true
      
      respond_to do |format|
        format.html { redirect_to(:controller => "users", :action => "index") }
      end
      
    else
      
      session[:autorizado] = false
      
      respond_to do |format|
        format.html { redirect_to(:controller => "home", :action => "index") }
      end
      
    end
    
    
  end
  
  
  private
  
  def generateQuestion
    
    questions = GenerateQuestionController.getQuestions()
    
    return questions
    
  end
  
  
  

end
