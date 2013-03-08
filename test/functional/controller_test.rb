require 'test_helper'

class ControllerTest < ActionController::TestCase
  tests ArticlesController

  test 'creating an action' do
    post :create, article: { title: 'Hello, World!', body: 'Lorem Ipsum' }
    assert_equal 1, assigns(:article).actions.size
  end

  test 'hound_user defaults to current_user' do
    post :create, article: { title: 'Hello, World!', body: 'Lorem Ipsum' }
    assert_equal User.first, assigns(:article).actions.first.user
  end
end