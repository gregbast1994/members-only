class UsersController < ApplicationController
    before_action :correct_user, only: [:edit, :update]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user
        else
            render 'new'
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to @user
            flash[:success] = "Profile updated"
        else
            render 'edit'
        end
    end

    private

    def correct_user
        @user = User.find(params[:id])
        flash[:danger] = "Sorry, you have attempted to access an unathorized page"
        redirect_to root_path unless current_user?(@user)
    end

    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
    end
end
