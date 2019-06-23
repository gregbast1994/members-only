require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'should return formatted title' do
    assert_equal full_title, 'Members Only'
    assert_equal full_title('Help'), 'Help | Members Only'
  end
end
