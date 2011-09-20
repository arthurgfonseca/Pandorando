class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.xml
  
  def index

    @answers = Answer.all
 
    @answer = Answer.new
    @index = "answers"
    
    puts'ANSWER'
    puts @answers[0].question

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end
  
  def addChar
    
    @answer = Answer.find(params[:id])
    @characteristics = Characteristic.get_characteristics

    if(params[:characteristic].to_s != "")
       characteristic_weight = @answer.AnswerCharacteristicWeight.build 
       characteristic_weight.characteristic_id = params[:characteristic]
       characteristic_weight.weight = params[:weight].to_f
       characteristic_weight.save
     end

     respond_to do |format|
          format.js
     end
    
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end
  

  # POST /answers
  # POST /answers.xml
  def create
    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@answer, :notice => 'Answer was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])
    @answer.enunciation = params[:enunciado];
    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@answer, :notice => 'Answer was successfully updated.') }
        format.js
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.js
    end
  end
  
  def newCharacteristic
    
    puts 'passei aki no newCharacteristic'
    
  end
  
end
