require 'test_helper'

class PostEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:greg)
    @other_user = users(:adina)
  end

  test 'a user can only edit her own post' do
    log_in_as(@user)
    assert_difference 'Post.count' do
      post posts_path, params: { post: { content: 'foobar' } }
    end
    log_in_as(@other_user)
    @post = @user.posts.first
    new_message = 'batbaz'
    patch post_path(@post), params: { post: { content: new_message } }
    @post.reload
    assert_not_equal @post.content, new_message

  end
    

end
