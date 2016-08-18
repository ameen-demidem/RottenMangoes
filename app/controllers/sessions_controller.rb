class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id 
      redirect_to movies_path, notice: "Welcome back, #{@user.firstname}!"
    else
      flash.now.alert = "Wrong email or password!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "See you soon!"
  end
end
