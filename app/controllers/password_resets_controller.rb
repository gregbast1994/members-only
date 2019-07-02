class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
    @user = User.new()
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
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

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password reset!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end


  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.activated && @user.authenticated?(:reset_password, params[:id])
      flash[:danger] = "Invalid email/token"
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired!"
      redirect_to new_password_reset_url
    end
  end

end
