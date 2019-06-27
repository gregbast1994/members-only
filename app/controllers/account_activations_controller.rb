class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: URI.decode(params[:account_activations][:email]))
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:account_activations][:id])
      @user.activate
      log_in @user
      redirect_to @user.show
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
