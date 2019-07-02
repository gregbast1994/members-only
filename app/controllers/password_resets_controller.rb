class PasswordResetsController < ApplicationController
  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:users][:email])
    if @user
      @user.create_reset_password_digest
      @user.send_reset_password_email
      flash[:info] = "check your email for password reset link!"
      redirect_to root_path
    else
      flash[:warning] = "Invalid email"
      render 'new'
    end
    
  end
end
