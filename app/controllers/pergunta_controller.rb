class PerguntaController < ApplicationController
  # GET /pergunta
  # GET /pergunta.xml
  def index
    @pergunta = Perguntum.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pergunta }
    end
  end

  # GET /pergunta/1
  # GET /pergunta/1.xml
  def show
    @perguntum = Perguntum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @perguntum }
    end
  end

  # GET /pergunta/new
  # GET /pergunta/new.xml
  def new
    @perguntum = Perguntum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @perguntum }
    end
  end

  # GET /pergunta/1/edit
  def edit
    @perguntum = Perguntum.find(params[:id])
  end

  # POST /pergunta
  # POST /pergunta.xml
  def create
    @perguntum = Perguntum.new(params[:perguntum])

    respond_to do |format|
      if @perguntum.save
        format.html { redirect_to(@perguntum, :notice => 'Perguntum was successfully created.') }
        format.xml  { render :xml => @perguntum, :status => :created, :location => @perguntum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @perguntum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pergunta/1
  # PUT /pergunta/1.xml
  def update
    @perguntum = Perguntum.find(params[:id])

    respond_to do |format|
      if @perguntum.update_attributes(params[:perguntum])
        format.html { redirect_to(@perguntum, :notice => 'Perguntum was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @perguntum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pergunta/1
  # DELETE /pergunta/1.xml
  def destroy
    @perguntum = Perguntum.find(params[:id])
    @perguntum.destroy

    respond_to do |format|
      format.html { redirect_to(pergunta_url) }
      format.xml  { head :ok }
    end
  end
end
