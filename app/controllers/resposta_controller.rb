class RespostaController < ApplicationController
  # GET /resposta
  # GET /resposta.xml
  def index
    @resposta = Respostum.all
    @respostum = Respostum.new

    respond_to do |format|
      format.html # index.html.erb
      format.js # Ajax CRUD
    end
  end

  # GET /resposta/1
  # GET /resposta/1.xml
  def show
    @respostum = Respostum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js # Ajax CRUD
    end
  end

  # GET /resposta/new
  # GET /resposta/new.xml
  def new
    @respostum = Respostum.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # Ajax CRUD
    end
  end

  # GET /resposta/1/edit
  def edit
    @respostum = Respostum.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.js # Ajax CRUD
    end
  end

  # POST /resposta
  # POST /resposta.xml
  def create
    @respostum = Respostum.new(params[:respostum])

    respond_to do |format|
      if @respostum.save
        format.html { redirect_to(@respostum, :notice => 'Respostum was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
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
        format.js
      else
        format.html { render :action => "edit" }
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
      format.js
    end
  end
end
