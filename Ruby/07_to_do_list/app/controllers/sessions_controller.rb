class SessionsController < ApplicationController

  def new
    @last_failed = flash[:last_request_failed]
    @last_failed ||= false
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
    else
      flash[:last_request_failed] = true
    end
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
