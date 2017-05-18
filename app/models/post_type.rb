class PostType < ActiveRecord::Base
  # ---- constantine ----

  constantine :alias

  # ---- relationships ----

  has_many :posts
end
