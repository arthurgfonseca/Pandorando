class GiftsController < ApplicationController
  # GET /gifts
  # GET /gifts.xml
  def index
    
    if session[:autorizado] == true
      # @gifts = (Gift.limit((Constants::PAGINA).to_i)).asc(:name)
      @gifts = Gift.asc(:name)
      @gift = Gift.new
      @index = "presentes"
      @perfis = Perfil.all

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

  # GET /gifts/1
  # GET /gifts/1.xml
  def show
    @gift = Gift.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /gifts/new
  # GET /gifts/new.xml
  def new
    @gift = Gift.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /gifts/1/edit
  def edit
    @gift = Gift.find(params[:id])
  end

  # POST /gifts
  # POST /gifts.xml
  def create
    
    @gift = Gift.new(params[:gift])

    respond_to do |format|
      if @gift.save
        format.html { redirect_to(@gift, :notice => 'Gift was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /gifts/1
  # PUT /gifts/1.xml
  def update
    @gift = Gift.find(params[:id])

    respond_to do |format|
      if @gift.update_attributes(params[:gift])
        format.html { redirect_to(@gift, :notice => 'Gift was successfully updated.') }
        format.js
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /gifts/1
  # DELETE /gifts/1.xml
  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy

    respond_to do |format|
      format.html { redirect_to(gifts_url) }
      format.js
    end
  end
end
