class UserType < ActiveRecord::Base
  # ---- constantine ----

  constantine :alias

  # ---- relationships ----

  has_many :users
end
