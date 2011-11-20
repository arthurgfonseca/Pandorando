class HomePageController < ApplicationController
  
  
  layout "homePage"
  
  def index
    
    session[:autorizado] = false
    respond_to do |format|
      format.html # new.html.erb
      format.js # Ajax CRUD
    end
  end
  
end
