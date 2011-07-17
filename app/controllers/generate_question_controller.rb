class GenerateQuestionController < ApplicationController
  layout 'home'
  
  
  def nextQuestion
    
    @questions = GenerateQuestionController.getQuestions()
    arrPesos = session[:arrPesos]
    @lastQuestion = false
    @questionNumber = (params[:questionNumber]).to_i
    
    #TODO
    opcao1 = params[:Sim]
    opcao2 = params[:Nao]
    
    
    if(opcao1)
      answer = @questions[@questionNumber.to_i].answers[0]
      answerWithChar = Answer.find(answer.id, :include => :characteristics)
      char = answerWithChar.characteristics
      arrPesos[0] = arrPesos[0].to_i + char[0].load
      arrPesos[1] = arrPesos[1].to_i + char[1].load
      
    end
    
    if(opcao2)
      answer = @questions[@questionNumber.to_i].answers[1]
      answerWithChar = Answer.find(answer.id, :include => :characteristics)
      char = answerWithChar.characteristics
      arrPesos[0] = arrPesos[0].to_i + char[0].load
      arrPesos[1] = arrPesos[1].to_i + char[1].load
    end
    
    session[:arrPesos] = arrPesos
    
    
    #Check if it is the last question
    if(@questions.size <= @questionNumber + 1)
      @lastQuestion = true
      getResult()
    else
      @questionNumber = @questionNumber.next
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.js # Ajax CRUD
    end
    
  end
  
  private
  
  def self.getQuestions
    
    return Question.find(:all, :include => :answers)
    
  end
  
  def getResult
    puts 'passei aki'
    arrPesos = session[:arrPesos]
  end
  
  
  
  
end
