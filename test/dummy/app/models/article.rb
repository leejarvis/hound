class Article < ActiveRecord::Base
  attr_accessible :body, :title
  hound
end
