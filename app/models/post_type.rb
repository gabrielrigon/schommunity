class PostType < ActiveRecord::Base
  # ---- relationships ----

  has_many :posts
end
