class Gender < ActiveRecord::Base
  # ---- relationships ----

  has_many :users
end
