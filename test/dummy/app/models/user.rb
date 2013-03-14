class User < ActiveRecord::Base
  attr_accessible :name
  hound_user
end
