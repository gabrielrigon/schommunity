class State < ActiveRecord::Base
  # ---- relationships ----
  
  has_many :cities
  has_many :addresses
end
