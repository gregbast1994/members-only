require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'greg',
                    email: 'greg@greg.com',
                    password: 'password',
                    password_confirmation: 'password')
  end

  test 'name cannot be blank' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email cannot be blank' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'password digest cannot be blank' do
    @user.password_digest = ''
    assert_not @user.valid?
  end

  test 'password must equal password_confirmation' do
    @user.password = '123123'
    @user.password_confirmation = 'foobar'
    assert_not @user.valid?
  end

  test 'password must be atleast 6 characters' do
    @user.password, @user.password_confirmation = '1'
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com foo@bar..com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email validation' do
    valid_addresses = %w[user@example.com USER@foo.COM 
      A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid? "#{address.inspect} should be valid"
    end
  end

  test 'email is downcased before save' do
    mixed_email, @user.email = 'GrEg@AoL.com'
    @user.save
    assert_not_equal mixed_email, @user.email
  end

  test 'emails are unique' do
    other_user = @user.dup
    @user.save
    assert_not other_user.valid?
  end

  
end
