class GiftsController < ApplicationController
  # GET /gifts
  # GET /gifts.xml
  def index
    @gifts = Gift.all
    @gift = Gift.new
    @index = "gifts"
    @perfis = Perfil.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
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
    puts "ENTREI CREATE GFASFHLADKSFKJSADGLHJKDSLGHJKASDHJLGKHAJLSDGLHJASDHJAHJLGKSLHGJD"
    @gift = Gift.new(params[:gift])
    
    perfil1 = params[:Intelectual]
    puts perfil1
    
    if(perfil1)
      puts "entrei aki no perfil1"
      perfil = Perfil.where(:title => "Intelectual").first
      puts perfil
      puts perfil.title
      @gift.perfils.concat([perfil])
    end
    
    perfil2 = params[:Esportista]
    
    if(perfil2)
      perfil = Perfil.where(:title => "Esportista").first
      @gift.perfils.concat([perfil])
    end
    
    perfil3 = params[:Alternativo]
    
    if(perfil3)
      perfil = Perfil.where(:title => "Alternativo").first
      @gift.perfils.concat([perfil])
    end
    
    
    perfil4 = params[:Fun]
    
    if(perfil4)
      perfil = Perfil.where(:title => "Fun").first
      @gift.perfils.concat([perfil])
    end
    
    perfil5 = params[:Comum]
    
    if(perfil5)
      perfil = Perfil.where(:title => "Comum").first
      @gift.perfils.concat([perfil])
    end
    
    perfil6 = params[:Geral]
    
    if(perfil6)
      perfil = Perfil.where(:title => "Geral").first
      @gift.perfils.concat([perfil])
    end

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
