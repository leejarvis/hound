class Post < ActiveRecord::Base
  attr_accessible :text
  hound actions: 'update', limit: 3
end
