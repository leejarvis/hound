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