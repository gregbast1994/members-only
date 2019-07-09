require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:greg)
    @other_user = users(:adina)
  end

  test 'post form only visible if logged in and hidden field defining parent_id' do
    get user_path(@user)
    assert_template 'users/show'
    ## not logged in
    assert_select 'input#post_parent_id', count: 0
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!
    assert_select 'input#post_parent_id', count: 1
  end

end
