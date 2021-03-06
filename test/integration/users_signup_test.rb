require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test 'valid signup info with account activation' do
    get signup_path

    assert_difference 'User.count' do
      post users_path, params: { user: { name: 'greg',
                                         email: 'user@invalid.com',
                                         password: 'foobar',
                                         password_confirmation: 'foobar' } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    #try to login before activation
    log_in_as(user)
    assert_not is_logged_in?
    #Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    #valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    #valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
end

  test 'signup with invalid info' do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
        email: '',
        password: '1',
        password_confirmation: '2' } }
    end

    assert_select 'div#error_explanation', count: 1
  end

    
end
