class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  def index
    @questions = Question.all
    @question = Question.new
    @index = "questions"

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])
    puts 'passei show'
    puts @question

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end
  
  def addAnswer
     @question = Question.find(params[:id])
     @first = true
     
     if(params[:enunciado].to_s != "")
       @first = false
       @answer = @question.answers.build 
       @answer.enunciation = params[:enunciado]
       @answer.save
     end

     respond_to do |format|
          format.html { redirect_to("/questions") }
          format.js
     end
   end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    
    puts @question.answers

    respond_to do |format|
      if @question.save
        
        # puts @question.answers
        # puts answers[1].question
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.js
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.js
    end
  end
end
