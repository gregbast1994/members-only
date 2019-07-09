class PostsController < ApplicationController
    before_action :logged_in, only: [:create, :update]

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
        else
            redirect_back(fallback_location: user_path(current_user))
        end
    end

    private

    def post_params
        params.require(:post).permit(:content)
    end

    def logged_in
        unless logged_in?
            flash[:warning] = "You must be logged in for that"
            redirect_to login_path
        end
    end
end
