class UsersController < ApplicationController
    before_action :correct_user, only: [:edit, :update]
    before_action :require_login, except: [:new, :create]
    before_action :admin?, only: [:destroy]

    def new
        redirect_to current_user if logged_in?
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            @user.send_activation_email
            flash[:warning] = "Please check your email for an activation link"
            redirect_to root_path
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

    def destroy
        @user = User.find(params[:id])
        unless @user == current_user
            @user.delete 
            redirect_to users_path
        end
    end

    private

    def admin?
        redirect_to root_path unless current_user.admin?
    end 

    def require_login
        unless logged_in?
            flash[:danger] = "You must be logged in to do that"
            redirect_to login_path
        end
    end

    def correct_user
        @user = User.find(params[:id])
        unless current_user?(@user)
            flash[:danger] = "wrong page buddy"
            redirect_to root_url
        end
    end

    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
    end
end
