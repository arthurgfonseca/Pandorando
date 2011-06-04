class UsuariosController < ApplicationController
  # GET /usuarios
  # GET /usuarios.xml
  
  before_filter :load
  
  def load
    @usuarios = Usuario.all
    @usuario = Usuario.new
  end
  
  def index
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      flash[:notice] = "Usuario criado com sucesso!"
      @usuarios = Usuario.all;
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(params[:id])
      flash[:notice] = "Usuario atualizado com sucesso!"
      @usuarios = Usuario.all;
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    flash[:notice] = "Usuario removido com sucesso!"
  end
end
