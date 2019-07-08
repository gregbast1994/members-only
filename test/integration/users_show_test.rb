require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:greg)
  end

  test 'should display post based on login status' do
    get users_path(@user)
    assert_select '#new_post', 0
    log_in_as(@user)
    follow_redirect!
    assert_select '#new_post', 1
  end
end
