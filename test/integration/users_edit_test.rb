require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:greg)
    @other_user = users(:adina)
  end

  test 'should be no difference with invalid submission' do
    log_in_as(@user)
    patch user_path(@user), params: { user: { name: '',
                                              email: '' } }
    assert_template 'users/edit'
    assert_select 'div#error_explaination', count: 1
  end

  test 'edit with valid information' do
    log_in_as(@user)
    get edit_user_path(@user)
    name = 'alan'
    email = 'alan@alan.com'
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: '',
                                              password_confirmation: '' } }
    assert_redirected_to @user
    follow_redirect!
    assert_not_empty flash[:success]
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test 'should redirect user when accessing unauthorized page' do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url
  end

  test 'user should not be able to edit user via commandline' do
    log_in_as(@other_user)
    password_digest = @user.password_digest
    patch user_path(@user), params: { user: { password: 'other_pass',
                                              password_confirmation: 'other_pass' } }
    @user.reload
    assert_equal password_digest, @user.password_digest
  end
end
