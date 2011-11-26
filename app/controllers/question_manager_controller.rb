class QuestionManagerController < ApplicationController

  def index
    
    if session[:autorizado] == true
      @questions = Question.all
      @question = Question.new
      @index = "question_manager"

      respond_to do |format|
        format.html # index.html.erb
        format.js
      end
    else
      
        respond_to do |format|
          format.html { redirect_to(:controller => "home", :action => "admin") }
        end
      
    end
    
  end
  
  
end