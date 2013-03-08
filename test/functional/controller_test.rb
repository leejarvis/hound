require 'test_helper'

class ControllerTest < ActionController::TestCase
  tests ArticlesController

  test 'creating an action' do
    post :create, article_attributes
    assert_equal 1, assigns(:article).actions.size
  end

  test 'hound_user defaults to current_user' do
    post :create, article_attributes
    assert_equal User.first, assigns(:article).actions.first.user
  end

  test 'custom actions' do
    article = Article.create title: 'Salut, World!', body: 'Lorem Ipsum'
    put :update, article_attributes.merge(id: article.id)
    actions = assigns(:article).actions
    assert_equal 3, actions.size # one to create, one to update, one custom
    assert_equal 'something_custom', actions.last.action
    assert_equal User.first, actions.last.user
  end

  private

  def article_attributes
    { article: { title: 'Hello, World!', body: 'Lorem Ipsum' } }
  end
end