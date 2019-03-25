class SessionsController < ApplicationController


  def new

  end

  def create
    user = User.find_by_username(params[:username])
	if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.role == "officer"
        redirect_to officer_path(current_user.officer), notice: "Logged in!"
      else
        redirect_to dashboard_path, notice: "Logged in!"
      end
    else
      flash.now.alert = "Username and/or password is invalid"

      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: "Logged out!"
  end
end




