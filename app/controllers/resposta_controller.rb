class RespostaController < ApplicationController
  # GET /resposta
  # GET /resposta.xml
  def index
    @resposta = Respostum.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resposta }
    end
  end

  # GET /resposta/1
  # GET /resposta/1.xml
  def show
    @respostum = Respostum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @respostum }
    end
  end

  # GET /resposta/new
  # GET /resposta/new.xml
  def new
    @respostum = Respostum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @respostum }
    end
  end

  # GET /resposta/1/edit
  def edit
    @respostum = Respostum.find(params[:id])
  end

  # POST /resposta
  # POST /resposta.xml
  def create
    @respostum = Respostum.new(params[:respostum])

    respond_to do |format|
      if @respostum.save
        format.html { redirect_to(@respostum, :notice => 'Respostum was successfully created.') }
        format.xml  { render :xml => @respostum, :status => :created, :location => @respostum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @respostum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resposta/1
  # PUT /resposta/1.xml
  def update
    @respostum = Respostum.find(params[:id])

    respond_to do |format|
      if @respostum.update_attributes(params[:respostum])
        format.html { redirect_to(@respostum, :notice => 'Respostum was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @respostum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resposta/1
  # DELETE /resposta/1.xml
  def destroy
    @respostum = Respostum.find(params[:id])
    @respostum.destroy

    respond_to do |format|
      format.html { redirect_to(resposta_url) }
      format.xml  { head :ok }
    end
  end
end
