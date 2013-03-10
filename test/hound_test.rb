require 'test_helper'

class HoundTest < ActiveSupport::TestCase
  setup do
    @article = Article.create! title: 'Hello, World!', body: 'Some body'
  end

  test 'hound_options' do
    assert_equal %w'create update destroy', Article.hound_options[:actions]
    assert_equal %w'update', Post.hound_options[:actions]
  end

  test 'hound model creation' do
    assert_equal 1, @article.actions.size
    assert_kind_of Hound::Action, @article.actions.first
    assert_equal 'create', @article.actions.first.action
  end

  test 'hound model update' do
    @article.update_attributes(title: 'Salut, World!')
    assert_equal 'update', @article.actions.last.action
  end

  test 'hound model destroy' do
    @article.destroy
    action = @article.actions.last
    assert_equal 'destroy', action.action
    assert_equal 'Article', action.actionable_type
    assert_equal @article.id, action.actionable_id
  end

  test 'limiting actions' do
    @post = Post.create! text: 'lorem ipsum'
    5.times do |n|
      @post.update_attributes(text: "lorem ipsum #{n}")
    end
    assert_equal 3, @post.actions.size
  end

  test 'user has many actions' do
    user = User.create! name: 'Lee'
    assert user.respond_to?(:actions)
    article = Article.create! title: 'Hello, World!'
    action = article.actions.last
    action.user = user
    assert action.save
    assert_equal article.actions, user.actions
  end
end
