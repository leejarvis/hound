class Post < ActiveRecord::Base
  attr_accessible :text
  hound actions: 'create'
end
