require 'test_helper'

class TestUserClass; end
class TestUserClass2; end

class ConfigTest < ActiveSupport::TestCase

  test 'user_class' do
    assert_equal User, Hound.config.user_class

    Hound.config.user_class = TestUserClass
    assert_equal TestUserClass, Hound.config.user_class

    Hound.config.user_class = 'TestUserClass2'
    assert_equal TestUserClass2, Hound.config.user_class
  end

end
