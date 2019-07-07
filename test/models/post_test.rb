require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:greg)
    @post = @user.posts.build(content: 'abc123')
  end

  test 'content cannot be blank or greater than 140 characters ' do
    @post.content = '   '
    assert_not @post.valid?
    @post.content = 'a'*141
    assert_not @post.valid?
    @post.content = 'asdasd'
    assert @post.valid?
  end

  test 'user_id cannot be blank' do
    @post.user_id = '   '
    assert_not @post.valid?
    @post.user_id = @user.id
    @post.valid?
  end
end