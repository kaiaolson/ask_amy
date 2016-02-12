class WelcomeController < ApplicationController
  # we call instance methods defined in a controller 'actions'
  # we need actions in order to handle user requests
  def index
  end

  def about
    cookies.signed[:abc] = "xyz"
    cookies.signed[:hello] = "goodbye"
    # session is a single cookie that stores a hash that gets decrypted on the server side; more secure
    # cookies have default expir date, but session default lasts until sign out
    session[:foo] = "bar"
    session[:foo1] = "bar1"
    session[:foo2] = "bar2"
  end

  def greet
    @name = params[:name]
    Rails.logger.info ">>>>>>>>>>"
    Rails.logger.info cookies.signed[:hello]
    Rails.logger.info ">>>>>>>>>>"
  end
end
