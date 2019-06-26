require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:greg)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', logout_path
    get logout_path
    assert_nil session[:user_id]
  end

  test 'remember user even after closing the browser' do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
    session.delete(:user_id)
    get root_url
    assert_select 'a[href=?]', logout_path
  end

  test 'forget user' do
    log_in_as(@user, remember_me: '1')
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
    assert_empty cookies[:user_id]
  end

end
