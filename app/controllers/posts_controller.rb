class PostsController < ApplicationController
    before_action :logged_in, only: [:new, :create, :edit, :update]
    before_action :valid_user, only: [:edit, :update, :destroy]

    def index
        @posts = Post.all
    end
    
    def new
        @post = Post.new
    end

    def create
        @user = current_user
        @post = @user.posts.build(post_params)
        @post.save ? flash.now[:success] = "Posted" : flash.now[:danger] = "Error"
        redirect_back(fallback_location: user_path(current_user))
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find_by(id: params[:id])
        if @post.update_attributes(post_params)
            flash.now[:success] = "Post edited"
            redirect_to @post
        else
            flash.now[:danger] = "Error"
            redirect_back(fallback_location: user_path(current_user))
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    private

    def post_params
        params.require(:post).permit(:content, :parent_id)
    end

    def logged_in
        unless logged_in?
            flash[:warning] = "You must be logged in for that"
            redirect_to login_path
        end
    end

    def valid_user
        @post = Post.find(params[:id])
        unless is_post_owner?(@post)
            flash.now[:danger] = "Unauthorized area"
            redirect_to root_path
        end
    end
end
