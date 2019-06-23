require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'get signup path' do
    get signup_path
    assert_template 'users/new'
  end
end
