require 'test_helper'

class EditPasswordResetTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:greg)
  end

  test 'display error and render new' do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path params: { users: { email: '' } }
    assert_not_empty flash[:warning]
  end

  test 'redirect to root on valid user' do
    post password_resets_path params: { users: { email: @user.email } }
    assert_redirected_to root_url
    follow_redirect!
    assert_not_empty flash[:info]
  end

end
