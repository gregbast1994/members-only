require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'signup with valid information with redirect' do
    post users_path, params: { user: { name: 'greg',
                                      email: 'greg@greg.com',
                                      password: 'password',
                                      password_confirmation: 'password' } }
    follow_redirect!
    assert_template 'users/show'
  end

  test 'signup with invalid info' do
    assert_no_difference 'User.count' do
    post users_path, params: { user: { name: '',
      email: '',
      password: '1',
      password_confirmation: '2' } }
    end

    assert_select 'div#error_explaination', count: 1
  end
    
end
