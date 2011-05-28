class PresentesController < ApplicationController
  # GET /presentes
  # GET /presentes.xml
  def index
    @presentes = Presente.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @presentes }
    end
  end

  # GET /presentes/1
  # GET /presentes/1.xml
  def show
    @presente = Presente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @presente }
    end
  end

  # GET /presentes/new
  # GET /presentes/new.xml
  def new
    @presente = Presente.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @presente }
    end
  end

  # GET /presentes/1/edit
  def edit
    @presente = Presente.find(params[:id])
  end

  # POST /presentes
  # POST /presentes.xml
  def create
    @presente = Presente.new(params[:presente])

    respond_to do |format|
      if @presente.save
        format.html { redirect_to(@presente, :notice => 'Presente was successfully created.') }
        format.xml  { render :xml => @presente, :status => :created, :location => @presente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @presente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /presentes/1
  # PUT /presentes/1.xml
  def update
    @presente = Presente.find(params[:id])

    respond_to do |format|
      if @presente.update_attributes(params[:presente])
        format.html { redirect_to(@presente, :notice => 'Presente was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @presente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /presentes/1
  # DELETE /presentes/1.xml
  def destroy
    @presente = Presente.find(params[:id])
    @presente.destroy

    respond_to do |format|
      format.html { redirect_to(presentes_url) }
      format.xml  { head :ok }
    end
  end
end
