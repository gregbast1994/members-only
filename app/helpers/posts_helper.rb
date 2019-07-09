module PostsHelper
    def is_post_owner?(post)
        post.user == current_user
    end
end
