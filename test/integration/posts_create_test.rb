require 'test_helper'

class PostsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:greg)
    @other_user = users(:adina)
  end

  test 'can submit post from users show if logged in' do
    ## must be logged in
    get user_path(@user)
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: 'foobar' } }
    end
    log_in_as(@user)
    get user_path(@user)
    assert_difference 'Post.count' do
      post posts_path, params: { post: { content: 'foobar' } }
    end
    follow_redirect!
    assert_template 'users/show'

  end

end
