class SessionsController < ApplicationController
  def new
    redirect_to current_user if logged_in?
  end

  #need to check for cookies too!
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combo'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
