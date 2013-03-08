# Hound

## Installation

Add Hound to your `Gemfile` and run `bundle install`:

```ruby
gem 'hound'
```

Hound expects a `hound_actions` table to exist in your schema, go ahead
and run the generator provided:

```
rails generate hound:install
```

This will create a new migration file. Run `rake db:migrate` to add
this table.

## Usage

Hound will automatically track `create` `update` and `destroy` methods that
occur on your 'hounded' models. You can tell Hound which actions you'd like
to track in the `hound` method:

```ruby
class Article < ActiveRecord::Base
  hound actions: [:create, :update] # only track create/update
end
```

Hound also adds a `hound_action` helper method to your controllers. This
allows you to set a custom action on any of your hounded models.

```ruby
class ArticlesController < ApplicationController
  def add_to_frontpage
    # Does not update @article so no action will be created
    @frontpage << @article
    hound_action @article, 'added_to_frontpage'
  end
end

@article.actions.last.action #=> 'added_to_frontpage'
```

Hound will track the current user making these changes assuming your
application controller responds to a `current_user` method. If you have a
custom method, you can override `hound_user` to return this instead.

```ruby
class ApplicationController < ActionController::Base
  def hound_user
    current_admin_user
  end
end
```