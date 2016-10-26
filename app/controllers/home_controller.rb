class HomeController < ApplicationController


  #this method is called `action`
  def index
    #this will render /index.html.erb
    #render :index, layout: 'application'
    #the line above is conventional default so we can do without it
    cookies[:last_visited] = Time.now
    cookies[:lucky_number] = rand(100)
  end

  def contact
  end

  def contact_submit
    @name = params[:full_name]
  end

end
