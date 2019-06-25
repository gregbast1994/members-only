require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:greg)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end


end
