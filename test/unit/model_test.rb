require 'test_helper'

class ModelTest < ActiveSupport::TestCase

  setup do
    @article = Article.create! title: 'Hello, World!', body: 'Lorem Ipsum'
  end

  test 'actions_for_date' do
    @article.actions.create!(action: 'created').tap { |x| x.created_at = 3.days.ago; x.save }
    @article.actions.create!(action: 'created').tap { |x| x.created_at = 5.days.from_now; x.save }
    @article.actions.create!(action: 'created').tap { |x| x.created_at = Date.today; x.save }
    assert_equal 2, @article.actions_for_date(2.days.ago..3.days.from_now).size
  end

  test 'avoid tracking actions on an instance' do
    article = Article.new title: 'Hello, World!', body: 'Lorem Ipsum'
    article.hound = false
    article.save
    assert_empty article.actions
  end

  test 'tracking model changes' do
    @article.update_attributes(title: 'Salut, World!')
    assert_equal({"title" => ["Hello, World!", "Salut, World!"]}, @article.actions.last.changeset)
  end

end