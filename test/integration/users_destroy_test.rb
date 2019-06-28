require 'test_helper'

class UsersDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:greg)
    @non_admin = users(:adina)
  end

  test 'should delete user when admin' do
    log_in_as(@admin)
    assert_difference 'User.count', -1 do
      delete user_path(User.last)
    end

  end

  test 'should not delete user when not admin' do
    log_in_as(@non_admin)
    assert_no_difference 'User.count' do
      delete user_path(User.last)
    end
  end


end
